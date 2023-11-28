use cosmwasm_schema::{cw_serde, QueryResponses};
use cosmwasm_std::Addr;

#[cw_serde]
pub struct InstantiateMsg {}

#[cw_serde]
pub enum ExecuteMsg {
    SendMsg{msg:String},
    Crash{},
}

#[cw_serde]
#[derive(QueryResponses)]
pub enum QueryMsg {
    #[returns(GetMsgResponse)]
    GetMsg{sender: Addr}
}


#[cw_serde]
pub struct GetMsgResponse {
    pub msg: String,
}
