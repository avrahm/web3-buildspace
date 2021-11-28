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
        // reference to the account. We use &mut to get a "mutable reference" to base_account. Allows us to modify the account
        let base_account = &mut ctx.accounts.base_account;
        base_account.total_gifs = 0;
        Ok(())
    }

    // Add gif Function
    pub fn add_gif(ctx: Context<AddGif>) -> ProgramResult {
        // Get a reference to the account and increment total_gifs.
        let base_account = &mut ctx.accounts.base_account;
        base_account.total_gifs += 1;
        Ok(())
    }
}

// another macro which acts like a class, interface, or an object
// Attach certain variables to the StartStuffOff context.
#[derive(Accounts)]
pub struct StartStuffOff<'info> {
    // initializes the BaseAccount data
    // https://docs.solana.com/developing/programming-model/accounts#rent
    #[account(init, payer = user, space = 9000)]
    pub base_account: Account<'info, BaseAccount>, // base_account is a reference to the BaseAccount

    #[account(mut)]
    pub user: Signer<'info>, // data passed into the program that proves to the program that the user calling this program actually owns their wallet account.

    pub system_program: Program<'info, System>, //  It is a program that is run by the system. SystemProgram is the program that basically runs Solana.
                                                // https://docs.solana.com/developing/runtime-facilities/programs#system-program
}

// Specify what data you want in the AddGif Context.
#[derive(Accounts)]
pub struct AddGif<'info> {
    // account(mut) is a reference to the BaseAccount and allows to change the total_gifs value
    #[account(mut)]
    pub base_account: Account<'info, BaseAccount>,
}

// Tell Solana what we want to store on this account. Data is stored in accounts not on the contract
// https://docs.solana.com/developing/programming-model/accounts
#[account]
pub struct BaseAccount {
    pub total_gifs: u64,
}
