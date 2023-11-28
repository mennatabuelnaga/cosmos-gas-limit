#[cfg(not(feature = "library"))]
use cosmwasm_std::entry_point;
use cosmwasm_std::{Binary, Deps, DepsMut, Env, MessageInfo, Response, StdResult, to_json_binary};
// use cw2::set_contract_version;

use crate::error::ContractError;
use crate::msg::{ExecuteMsg, InstantiateMsg, QueryMsg, GetMsgResponse};
use crate::state::{CONTRACT_CREATOR, MSGS};

/*
// version info for migration info
const CONTRACT_NAME: &str = "crates.io:infinite-loop";
const CONTRACT_VERSION: &str = env!("CARGO_PKG_VERSION");
*/

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn instantiate(
    deps: DepsMut,
    _env: Env,
    info: MessageInfo,
    _msg: InstantiateMsg,
) -> Result<Response, ContractError> {
    CONTRACT_CREATOR.save(deps.storage, &info.sender)?;
    Ok(Response::new().add_attribute("method", "instantiate"))
}

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn execute(
    deps: DepsMut,
    _env: Env,
    info: MessageInfo,
    msg: ExecuteMsg,
) -> Result<Response, ContractError> {
    match msg{
        ExecuteMsg::Crash{} => {
            while true{

            }
            Ok(Response::new().add_attribute("method", "crash"))

        }
        ExecuteMsg::SendMsg{msg} => {
            MSGS.save(deps.storage, info.sender, &msg)?;
            Ok(Response::new().add_attribute("method", "send_msg"))

        }
    }
}

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn query(deps: Deps, _env: Env, msg: QueryMsg) -> StdResult<Binary> {
   match msg {
    QueryMsg::GetMsg { sender } => {
        let msg = MSGS.load(deps.storage, sender)?;
        to_json_binary(&GetMsgResponse{msg})

    },
}
}

#[cfg(test)]
mod tests {}
