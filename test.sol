pragma solidity ^0.4.17;

contract Campaign {
    struct Request {
        string description;
        uint256 value;
        address recipient;
        bool complete;
    }

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    address public manager;
    uint256 public minimumContribution;
    address[] public approvers;
    Request[] public requests;

    constructor(uint256 minimum) public {
        manager = msg.sender;
        minimumContribution = minimum;
    }

    function contribute() public payable {
        require(msg.value > minimumContribution);
        approvers.push(msg.sender);
    }

    function createRequest(
        string description,
        uint256 value,
        address recipient
    ) public restricted {
        Request memory newRequest = Request({
            description: description,
            value: value,
            recipient: recipient,
            complete: false
        });

        requests.push(newRequest);
    }

    function approveRequest(Request request) public{
        // Make sure person calling this function has donated 
        bool isApprover = false;
        for (uint i = 0; i < approvers.length; i++) {
            if(approvers[i] == msg.sender){
                isApprover = true;
            }
        }
        require(isApprover);

        // Make sure person calling this function hasnt voted before
        for (uint i = 0; i < requests.approvers.length; i++){
            require(requests.approvers[i] != msg.sender);
        }
    }
}
