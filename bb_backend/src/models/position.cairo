use starknet::ContractAddress;

#[derive(Copy, Drop, Serde)]
#[dojo::model]
struct Position {
    #[key]
    player: ContractAddress,
    vec: Vec2,
    array: ArrayTrait<Vec2>,
    owner : felt252, // 'p' player , 'c' computer
}

#[derive(Copy, Drop, Serde, Introspect)]
struct Vec2 {
    x: u32,
    y: u32
}

#[derive(Copy, Drop, Serde, Introspect)]
struct Next {
    nx: u32,
    ny: u32,
    n_state : u32,
    by: u32,
    bx: u32,
    b_state : u32
}

trait Vec2Trait {
    fn is_grid(self: Vec2) -> bool;
}

impl Vec2Impl of Vec2Trait {

    fn is_grid(self : Vec2) -> bool { // 5x5 size grid
        if(self.x >0 && self.y > 0 self.x <6 && self.y <6){
            return true;
        }
        false
    }

}