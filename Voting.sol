// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

struct Candidate{
    address candidateAddress;
    string candidateName;
    uint numberOfVotes;
}

contract Voting{
    Candidate[] public candidates;
    address[] public voters;
    uint candidateCount;

    function addCandidates(string memory name)public{
        require(!candidateExists(msg.sender), "This person is registered as a voter so cannot be registered as candidate");
        Candidate memory candidate = Candidate({
            candidateAddress: msg.sender,
            candidateName: name,
            numberOfVotes: 0
        });
        candidates.push(candidate);
        candidateCount++;
    }

    function candidateExists(address newAddress)internal view returns(bool){
        bool found = false;
        for(uint i=0;i<candidates.length;i++){
            if(candidates[i].candidateAddress == newAddress){
                found = true;
            }
        }
        return found;
    }

    function addVoters()public{
        voters.push(msg.sender);
    }

    function vote(uint id)public{
        require(id <= candidateCount, "There is no candidate with this id");
        candidates[id-1].numberOfVotes++;
    }

    function getWinner()public view returns(string memory, uint){
        uint winner;
        for(uint i=1;i<candidates.length;i++){
            if(candidates[i].numberOfVotes > candidates[winner].numberOfVotes){
                winner = i;
            }
        }
        return (candidates[winner].candidateName, candidates[winner].numberOfVotes);
    }
}