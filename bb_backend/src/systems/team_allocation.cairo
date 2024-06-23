#[starknet::contract]
mod TeamManager {
    use starknet::{ContractAddress, get_caller_address, storage_access::StorageBaseAddress};

    #[storage]
    struct Storage {
        teams: [Team; 4],
        users: LegacyMap<ContractAddress, User>,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        UserAdded: UserAdded,
    }

    #[derive(Drop, starknet::Event)]
    struct UserAdded {
        #[key]
        user: ContractAddress,
        team_id: u8,
    }

    #[constructor]
    fn constructor(ref self: ContractState) {
        for i in 0..4 {
            self.teams[i] = Team {
                members: vec![],
                total_age: 0,
                location_counts: LegacyMap::new(),
                gender_counts: LegacyMap::new(),
                total_game_winning_count: 0,
            };
        }
    }

    #[abi(embed_v0)]
    impl TeamManager of super::ITeamManager<ContractState> {
        fn add_user(ref self: ContractState, user: User) {
            let caller = get_caller_address();
            let team_id = self.allocate_team(&user);
            self.teams[team_id].members.push(user);
            self.teams[team_id].total_age += user.age;
            *self.teams[team_id].location_counts.entry(user.location).or_insert(0) += 1;
            *self.teams[team_id].gender_counts.entry(user.gender).or_insert(0) += 1;
            self.teams[team_id].total_game_winning_count += user.game_winning_count;
            self.users.insert(caller, user);
            self.emit(UserAdded { user: caller, team_id: team_id });
        }

        fn get_team(self: @ContractState, team_id: u8) -> Team {
            self.teams[team_id]
        }

        fn get_user(self: @ContractState, address: ContractAddress) -> User {
            self.users.get(address).unwrap_or_else(|| panic!("User not found"))
        }
    }

    #[generate_trait]
    impl InternalFunctions of InternalFunctionsTrait {
        fn allocate_team(ref self: ContractState, user: &User) -> u8 {
            let mut min_team_id = 0;
            let mut min_score = u32::MAX;

            for i in 0..4 {
                let team = &self.teams[i];
                let score = self.calculate_imbalance_score(team, user);
                if score < min_score {
                    min_score = score;
                    min_team_id = i;
                }
            }

            min_team_id
        }

        fn calculate_imbalance_score(ref self: ContractState, team: &Team, user: &User) -> u32 {
            let mut score = 0;

            score += (team.total_age + user.age) / (team.members.len() as u32 + 1);

            let location_count = team.location_counts.get(&user.location).unwrap_or(0) + 1;
            score += location_count;

            let gender_count = team.gender_counts.get(&user.gender).unwrap_or(0) + 1;
            score += gender_count;

            score += (team.total_game_winning_count + user.game_winning_count) / (team.members.len() as u32 + 1);

            score
        }
    }
}