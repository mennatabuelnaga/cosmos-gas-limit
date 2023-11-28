
use cosmwasm_std::Addr;
use cw_storage_plus::{Map, Item};

/// The creator of the contract who can set the initial contract addresses. After that, only sudo can change them.
pub const CONTRACT_CREATOR: Item<Addr> = Item::new("contract_creator");

pub const MSGS: Map<Addr, String> = Map::new("msgs");

