fn main() -> Array<felt252>  {
    // let a2 = 1 -2 ;
    // let my :bool = a2 > 1000;
    let mut a = ArrayTrait::new();
    a.append(1);
    a.append(2);
    // let _first_value = a.pop_front().unwrap();
    let f1 = *a.at(0);
    let f2 = *a.at(1);
    println!("{} {} ",f1,f2);

    // dict();
    // dict2();
    // array2();
    
    // tuple();
    // dict0();
    println!("=============");
    check_point(1,1);
    put(1,2);
    a
}
fn dict0(){
    // dict에 array 넣기
    // let mut arr = ArrayTrait::<Felt252Dict<u64>>::new();
    // let mut balances: Felt252Dict<u64> = Default::default();
    // arr.append(balances);
    // arr.at(0).insert('123',123);
}
fn dict(){
    let mut balances: Felt252Dict<u64> = Default::default();

    // Insert Alex with 100 balance
    balances.insert('Alex', 100);
    let alex = balances.get('Alex');
    balances.insert('Alex',200);
    println!("{}",alex);
    let alex = balances.get('Alex');
    println!("{}",alex);
    let cc = 'a' + 1;
    println!("{} {} {} ",'a'*10,'a'+'b',cc);
    println!("who is bu? {}",balances.get('bu'));
}

fn put(y :u8, x :u8){
    let a = y*10+x;
    let b = y+x;
    println!("{} {} ",a,b);
    let mut dict :Felt252Dict<u8> = Default::default();
    dict.insert(23,'p');
    let ok = possible(y,x,dict);
    println!(" ok ! {}",ok);
}
fn check_point(y :u8,x :u8){
    let ny = array![1,1,0,2,2,2, 0,1,];
    let nx = array![0,1,1, 1, 0,2,2,2,];
    
    let len = ny.len();
    let mut i =0;
    println!("y : {}  x: {}",y,x);
    while i< len {
        
        let negative_y : bool = *ny[i]==2; // y is negative
        let negative_x : bool = *nx[i]==2; // x is negative
        println!("{} {} ",negative_y, negative_x);
        let mut next_y :u8 = 0;
        let mut next_x :u8 = 0;
        
        
        if(negative_y){
            next_y = y - 1 ;
        }else{
            next_y = y + *ny[i]; 
        }
        if(negative_x){
            next_x = x - 1 ;
        }else{
            next_x = x + *nx[i];
        }
        println!("{} {} ", next_y,next_x);
        i+=1;
    }
}
// one base. not zero base
fn possible(y :u8,x:u8, mut grid : Felt252Dict<u8>) -> bool {
    let flag = true;
    if(y>6 || x >6 || y<=0 || x<=0){
        return false;
    }

    println!("grid get =>{}",grid.get(23));
    let next_point  = (y+1)*10+(x+1);
    println!("next point {}",next_point);
    if(grid.get(next_point.into()) != 0){
        return false;
    }
    flag
}

fn dict2(){
    // let mut balances: Felt252Dict<Felt252Dict<u64>> = Default::default();
    println!("pass");
    // Insert Alex with 100 balance
    // balances.insert('Alex', Default::default);
    // balances.get('Alex').insert('blex',100);
    // let alex = balances.get('Alex');
    // println!("{}",balances);
}

fn array(){
    let mut arr = ArrayTrait::<Array<u64>>::new();
    arr.append(array![]);
    // arr[0].append('1');
    // println!("{}",arr[0]);
}
fn array2(){
    let mut arr = array![];
    arr.append(array![0,0,0,0,0]);
    arr.append(array![0,0,0,0,0]);
    arr.append(array![0,0,0,0,0]);
    arr.append(array![0,0,0,0,0]);
    arr.append(array![0,0,0,0,0]);

    println!("{}",*arr.at(0)[0]);
}
fn array3(){
    let mut arr = array![];
    arr.append(array![0,0,0,0,0]);
    arr.append(array![0,0,0,0,0]);
    arr.append(array![0,0,0,0,0]);
    arr.append(array![0,0,0,0,0]);
    arr.append(array![0,0,0,0,0]);

    println!("{}",*arr.at(0)[0]);
}

fn tuple(){
    // let tup =(0,0,0,0,0);
    println!("typle");

}