// use is the equivalent to the import statement 
use anchor_lang::prelude::*;

// the id of the program and tells solana how to run the program
declare_id!("Fg6PaFpoGXkYsidMpWTK6W2BeZ7FEfcYkg476zPFsLnS");

// #[] is a macro http://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/macros.html
// They allows us to define a function that takes no arguments and returns nothing
// sorta like inheriting a class
#[program]
// pub mod is a rust module. https://stevedonovan.github.io/rust-gentle-intro/4-modules.html
// Pub is the equivalent to the public keyword. A module is an easy way to define a collection of function and variables
pub mod project_2_solana_gif_portal_starter_contract {
    use super::*;
    // start_stuff_off takes some Context and outputs a ProgramResult
    // OK(()) is a ProgramResult that is a success https://doc.rust-lang.org/std/result/
    pub fn start_stuff_off(ctx: Context<StartStuffOff>) -> ProgramResult {
        Ok(())
    }
}

// another macro
#[derive(Accounts)]
pub struct StartStuffOff {}
