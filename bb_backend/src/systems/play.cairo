use dojo_starter::models::moves::Direction;
use dojo_starter::models::position::Position;

// define the interface
#[dojo::interface]
trait IActions {
    fn spawn(ref world: IWorldDispatcher);
    fn move(ref world: IWorldDispatcher, direction: Direction);

    fn put(ref world : IWorldDispatcher, position :Position )
}

// dojo decorator
#[dojo::contract]
mod actions {
    use super::{IActions, next_position};
    use starknet::{ContractAddress, get_caller_address};
    use dojo_starter::models::{
        position::{Position, Vec2}, moves::{Moves, Direction, DirectionsAvailable}
    };

    #[derive(Copy, Drop, Serde)]
    #[dojo::model]
    #[dojo::event]
    struct Moved {
        #[key]
        player: ContractAddress,
        direction: Direction,
    }

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn put(ref world :IWorldDispatcher, position:Position, owner :felt252){
            let player = get_caller_address();

        }
        // Implementation of the move function for the ContractState struct.
        fn move(ref world: IWorldDispatcher, direction: Direction) {
            // Get the address of the current caller, possibly the player's address.
            let player = get_caller_address();

            // Retrieve the player's current position and moves data from the world.
            let (mut position, mut moves) = get!(world, player, (Position, Moves));

            // Deduct one from the player's remaining moves.
            moves.remaining -= 1;

            // Update the last direction the player moved in.
            moves.last_direction = direction;

            // Calculate the player's next position based on the provided direction.
            let next = next_position(position, direction);

            // Update the world state with the new moves data and position.
            set!(world, (moves, next));
            // Emit an event to the world to notify about the player's move.
            emit!(world, (Moved { player, direction }));
        }
    }
}

// Define function like this:
fn next_position(mut position: Position, direction: Direction) -> Position {
    match direction {
        Direction::None => { return position; },
        Direction::Left => { position.vec.x -= 1; },
        Direction::Right => { position.vec.x += 1; },
        Direction::Up => { position.vec.y -= 1; },
        Direction::Down => { position.vec.y += 1; },
    };
    position
}
fn put(y :u8, x :u8){
    let a = y*10+x;
    let b = y+x;
    let mut dict :Felt252Dict<u8> = Default::default();
    dict.insert(23,'p');
    let ok = possible(y,x,dict);
}

fn check_point(y :u8,x :u8) -> u8 {
    let ny = array![1,1,0,2,2,2, 0,1,];
    let nx = array![0,1,1, 1, 0,2,2,2,];
    
    let len = ny.len();
    let mut i =0;
    println!("y : {}  x: {}",y,x);
    while i< len {
        
        let negative_y : bool = *ny[i]==2; // y is negative
        let negative_x : bool = *nx[i]==2; // x is negative

        let mut next_y :u8 = 0;
        let mut next_x :u8 = 0;
        
        let mut between_y :u8 = 0;
        let mut between_x :u8 = 0;
        if(negative_y){
            if(y < 2){
                i+=1;
                continue;
            }
            next_y = y - 2 ;
            between_y = y - 1 ;
        }else{
            next_y = y + *ny[i]; 
            between_y = y + *ny[i] * 2 ;
        }
        if(negative_x){
            if (x < 2 ){
                i+=1;
                continue;
            }
            next_x = x - 2 ;
            between_x = x - 1 ;
        }else{
            next_x = x + *nx[i];
            between_x = x + *nx[i] * 2;
        }
        i+=1;
    }
}
