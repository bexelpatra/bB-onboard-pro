use starknet::ContractAddress;

#[dojo::model]
#[derive(Drop, Serde, starknet::Store)]
struct User {
    address: ContractAddress,
    age: u32,
    location: felt252,
    gender: felt252,
    game_winning_count: u32,
}

#[dojo::model]
#[derive(Drop, Serde, starknet::Store)]
struct Team {
    members: Vec<User>,
    total_age: u32,
    location_counts: LegacyMap<felt252, u32>,
    gender_counts: LegacyMap<felt252, u32>,
    total_game_winning_count: u32,
}

#[dojo::interface]
trait ITeamManager<TContractState> {
    fn add_user(ref self: TContractState, user: User);
    fn get_team(self: @TContractState, team_id: u8) -> Team;
    fn get_user(self: @TContractState, address: ContractAddress) -> User;
}