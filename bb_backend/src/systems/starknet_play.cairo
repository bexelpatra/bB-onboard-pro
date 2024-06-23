use starknet::ContractAddress;
use starknet::get_caller_address;

#[starknet::contract]
mod bb_game {
    use starknet::{ContractAddress, storage_access::StorageBaseAddress};

    const GRID_SIZE: usize = 5;

    #[storage]
    struct Storage {
        grid: [[Option<Stone>; GRID_SIZE]; GRID_SIZE],
        player: Player,
        computer: Computer,
    }

    #[derive(Drop, Serde, starknet::Store)]
    pub struct Player {
        address: ContractAddress,
        play_record: u128,
    }

    #[derive(Drop, Serde, starknet::Store)]
    pub struct Computer {
        play_record: u128,
    }

    #[derive(Copy, Clone, PartialEq, Drop, Serde, starknet::Store)]
    pub enum Stone {
        PlayerStone,
        ComputerStone,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        StonePlaced: StonePlaced,
        StoneCaptured: StoneCaptured,
    }

    #[derive(Drop, starknet::Event)]
    struct StonePlaced {
        #[key]
        player: ContractAddress,
        x: usize,
        y: usize,
        stone: Stone,
    }

    #[derive(Drop, starknet::Event)]
    struct StoneCaptured {
        #[key]
        player: ContractAddress,
        x: usize,
        y: usize,
        captured_by: Stone,
    }

    #[constructor]
    fn constructor(ref self: ContractState, player_address: ContractAddress) {
        self.player.write(Player {
            address: player_address,
            play_record: 0,
        });
        self.computer.write(Computer {
            play_record: 0,
        });
    }

    #[external(v0)]
    fn place_stone(self: @ContractState, x: usize, y: usize) {
        let caller = get_caller_address();
        let mut grid = self.grid.read();

        if grid[x][y].is_none() {
            grid[x][y] = Some(Stone::PlayerStone);
            self.grid.write(grid);
            self.player.play_record.write(self.player.play_record.read() + 1);
            self.emit(StonePlaced {
                player: caller,
                x: x,
                y: y,
                stone: Stone::PlayerStone,
            });

            self.check_capture(x, y, Stone::PlayerStone);

            self.computer_move();
        }
    }

    fn computer_move(self: @ContractState) {
        let mut grid = self.grid.read();

        for x in 0..GRID_SIZE {
            for y in 0..GRID_SIZE {
                if grid[x][y].is_none() {
                    grid[x][y] = Some(Stone::ComputerStone);
                    self.grid.write(grid);
                    self.computer.play_record.write(self.computer.play_record.read() + 1);
                    self.emit(StonePlaced {
                        player: self.player.read().address,
                        x: x,
                        y: y,
                        stone: Stone::ComputerStone,
                    });

                    self.check_capture(x, y, Stone::ComputerStone);
                    return;
                }
            }
        }
    }

    fn check_capture(self: @ContractState, x: usize, y: usize, stone: Stone) {
        let mut grid = self.grid.read();
        let directions = [
            (0, 1), (1, 0), (1, 1), (-1, 1),
            (0, -1), (-1, 0), (-1, -1), (1, -1),
        ];

        for direction in directions.chunks(2) {
            let (dx1, dy1) = direction[0];
            let (dx2, dy2) = direction[1];

            if self.is_in_bounds(x as isize + dx1, y as isize + dy1)
                && self.is_in_bounds(x as isize + dx2, y as isize + dy2)
            {
                let neighbor1 = grid[(x as isize + dx1) as usize][(y as isize + dy1) as usize];
                let neighbor2 = grid[(x as isize + dx2) as usize][(y as isize + dy2) as usize];

                if neighbor1.is_some() && neighbor1.unwrap() != stone
                    && neighbor2.is_some() && neighbor2.unwrap() != stone
                {
                    grid[(x as isize + dx1) as usize][(y as isize + dy1) as usize] = Some(stone);
                    grid[(x as isize + dx2) as usize][(y as isize + dy2) as usize] = Some(stone);

                    self.emit(StoneCaptured {
                        player: self.player.read().address,
                        x: (x as isize + dx1) as usize,
                        y: (y as isize + dy1) as usize,
                        captured_by: stone,
                    });

                    self.emit(StoneCaptured {
                        player: self.player.read().address,
                        x: (x as isize + dx2) as usize,
                        y: (y as isize + dy2) as usize,
                        captured_by: stone,
                    });
                }
            }
        }
        self.grid.write(grid);
    }

    fn is_in_bounds(x: isize, y: isize) -> bool {
        x >= 0 && x < GRID_SIZE as isize && y >= 0 && y < GRID_SIZE as isize
    }
}