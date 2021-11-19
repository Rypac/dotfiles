# rustup: installer for Rust
# https://rustup.rs
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"

# Cargo: Rust package manager
# https://doc.rust-lang.org/cargo/
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
fish_add_path "$CARGO_HOME/bin"
