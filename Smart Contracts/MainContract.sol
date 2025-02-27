pragma solidity ^0.4.19;

contract Owned {

	address owner;

	function Owned() public {

		owner = msg.sender;
	}

	modifier onlyOwner() {

		require(msg.sender == owner);
		_;
	}
}


contract Rent is Owned {

	struct Person {

		address eth;
		string legalName;
		string email;
		uint aadhaar;

		string signTerms;

		uint[] myOwned;
		uint[] myRented;
	}

	struct Parties {

		address landlord;
		address tenant;

		string signLandlord;
		string signTenant;

		bool completed;
	}

	struct House {

		string addressHouse;
		string type_of_property;

		uint startEpoch;
		uint endEpoch;

		uint monthDuration;

		uint rentAmount;
		uint securityFee;
		uint registerFee;

		bool completed;
	}

	struct OtherDetails {

    	string latitude;
    	string longitude;

		string ipfs_url;

		uint squareFootage;
		uint numberBedrooms;
		string others;

		bool completed;
	}

	struct Checks {

		bool isValid;

		bool tenantApprove;
		bool govApprove;

		bool tenantCheck;

		bool paidRegisterFee;
		bool paidSecurityFee;
	}

	Parties[] public allParties;
	House[] public allHouses;
	OtherDetails[] public allOtherDetails;
	Checks[] public allChecks;

	mapping(address => Person) public addressToPerson;
	mapping(address => bool) private checkUser;
	mapping(uint => bool) private checkAadhaar;


	function Rent() public {

		checkUser[owner] = true;
		var govt = Person(owner, 'Owner', 'Owner', 0, 'None',  new uint[](0), new uint[](0));

		addressToPerson[owner] = govt;
	}


	function getDetails() view external returns(uint _aadhaar, uint[] _owned, uint[] _rented) {

	    if(checkUser[msg.sender] == true)
	    {
	        var currentUser = addressToPerson[msg.sender];
	        return(currentUser.aadhaar, currentUser.myOwned, currentUser.myRented);
	    }

	}

	event startMessage(string message);
	function createNewUser(string _name, string _email, uint _aadhaar, string _sign) external {

		if((checkUser[msg.sender] == true)||(checkAadhaar[_aadhaar] == true))
		{
			startMessage('Failed !! User already Registered..');
		}

		else if((checkUser[msg.sender] != true)&&(checkAadhaar[_aadhaar] != true))
		{
			var newUser = Person(msg.sender, _name, _email, _aadhaar, _sign, new uint[](0), new uint[](0));
			addressToPerson[msg.sender] = newUser;

			checkUser[msg.sender] = true;
			checkAadhaar[_aadhaar] = true;

			startMessage('Welcome !! Successful Registration on Tenancy');
		}
	}

	event registerParty(string message);
	function registerParties(address _tenant) external 	{

		require(msg.sender != _tenant);

		if(checkUser[msg.sender] == true)
		{
			if(checkUser[_tenant] == true)
			{
				var newParty = Parties(msg.sender, _tenant,'N/A', 'N/A', true);
				var index = allParties.push(newParty) - 1;

				var newHouse = House('No Address', 'No Property', 0, 0, 0, 0, 0, 0, false);
				allHouses.push(newHouse);

				var newDetails = OtherDetails('28.7041', '77.1025', 'Currently Not Supported', 0, 0, 'N/A', false);
				allOtherDetails.push(newDetails);

				var newChecks = Checks(false, false, false, false, false, false);
				allChecks.push(newChecks);

				var user = addressToPerson[msg.sender];
				user.myOwned.push(index);

				var tenant = addressToPerson[_tenant];
				tenant.myRented.push(index);

				registerParty('Tenant Successfully added, Proceed to Step 2');
			}

			else
			{
				registerParty('Tenant is not registered on Tenancy');
			}
		}

		else
		{
			registerParty('Register on Tenancy, before drafting a Contract');
		}
	}


	event registerHome(string message, uint FeePayable);

	function newHome(string _add, string _type, uint _startEpoch, uint _endEpoch, uint _months, uint _rent, uint _security) external {

		if(checkUser[msg.sender] == true)
		{
			var user = addressToPerson[msg.sender];

			uint num = user.myOwned.length - 1;

			if(num < 0)
			{
				registerHome('Kindly fill Step 1 before proceeding to Step 2', 0);
			}

			else
			{
				uint index = user.myOwned[num];
				var houseOwner = allParties[index];

				if(houseOwner.landlord != msg.sender)
				{
					registerHome('Kindly register on Tenancy, before drafting a Contract', 0);
				}

				else
				{
					var home = allHouses[index];

					if(home.completed == false)
					{
						home.addressHouse = _add;
						home.type_of_property = _type;

						home.startEpoch = _startEpoch;
						home.endEpoch = _endEpoch;

						home.monthDuration = _months;

						home.rentAmount = _rent;
						home.securityFee = _security;

						var _tenant = allParties[index].tenant;

						if((home.monthDuration < 12)&&(home.monthDuration > 0))
						{
							home.registerFee = 100;
							home.completed = true;

							registerHome("Information successfully entered, Proceed to Step-3", (home.registerFee));
						}

						else if(home.monthDuration <= 60)
						{
							if(_security > 0)
							home.registerFee = 100 + ((2 * 12 * _rent) / 100) + 1100;

							else
							home.registerFee = ((2 * 12 * _rent) / 100) + 1100;

							home.completed = true;

							registerHome("Information successfully entered, Proceed to Step-3", (home.registerFee));
						}

						else if(home.monthDuration <= 120)
						{
							if(_security > 0)
							home.registerFee = 100 + ((3 * 12 * _rent) / 100) + 1100;

							else
							home.registerFee = ((3 * 12 * _rent) / 100) + 1100;

							home.completed = true;

							registerHome("Information successfully entered, Proceed to Step-3", (home.registerFee));
						}

						else if(home.monthDuration <= 240)
						{
							if(_security > 0)
							home.registerFee = 100 + ((6 * 12 * _rent) / 100) + 1100;

							else
							home.registerFee = ((6 * 12 * _rent) / 100) + 1100;

							home.completed = true;
							registerHome("Information successfully entered, Proceed to Step-3", (home.registerFee));
						}

						else
						{
							home.completed = false;
							registerHome('Enter Duration of Contract Correctly.. (Min - 1 month, Max - 240 Months' , 0);
						}
					}

					else
					{
						registerHome('Home Registration already Completed ', 0);
					}

				}

			}
		}

		else
		{
			registerHome('Kindly register on Tenancy, before drafting a Contract', 0);
		}
	}

	event registerDetails(string message);
	function newDetails(string _lat, string _lon, uint _sqFt, uint _rooms, string _extra) external {

		if(checkUser[msg.sender] == true)
		{
			var user = addressToPerson[msg.sender];
			uint num = user.myOwned.length - 1;

			if(num < 0)
			{
				registerDetails('Kindly complete all the Previous Steps before Step 3');
			}

			else
			{
				uint index = user.myOwned[num];
				var houseOwner = allParties[index];

				if(houseOwner.landlord != msg.sender)
				{
					registerDetails('Current User is not the Registered Owner of the Property from Step 1');
				}

				else
				{
					var details = allOtherDetails[index];
					var home = allHouses[index];

					if(home.completed == false)
					{
						registerDetails('Kindly Complete Step 2 before proceeding to Step 3');
					}

					else if((details.completed == false)&&(home.completed == true))
					{
						details.latitude = _lat;
						details.longitude = _lon;
						details.squareFootage = _sqFt;
						details.numberBedrooms = _rooms;

						details.others = _extra;
						details.completed = true;

						registerDetails('Information added successfully, pay the Registration Fee and Sign Contract');
					}

					else
					{
						registerDetails('Information already added to the Contract, proceed to Next Steps');
					}
				}

			}
		}

		else
		{
			registerDetails('Kindly register on Tenancy, before drafting a Contract');
		}
	}

	event feePay(string message);
	function feePayment(string _sign, uint _currentRate) external payable {

		require(msg.value > 0 ether);

		if(checkUser[msg.sender] == true)
		{
			var user = addressToPerson[msg.sender];

			uint num = user.myOwned.length - 1;

			if(num < 0)
			{
				feePay('Complete all Steps, before paying Registration Fee');
			}

			else
			{

				uint index = user.myOwned[num];
				var party = allParties[index];
				var house = allHouses[index];
				var details = allOtherDetails[index];
				var checks = allChecks[index];

				if((details.completed == true)&&(house.completed == true)&&(party.completed == true))
				{
					user = addressToPerson[msg.sender];
					checks.paidRegisterFee = true;
					party.signLandlord = _sign;

					feePay('Registration Fee Payment Successful');
				}

				else
				{
					feePay('Complete all the Steps given above before Fee Payment');
				}
			}
		}

		else
		{
			feePay('Kindly register on Tenancy, before drafting..');
		}
	}


	function tenantData1() view external returns (

		string landlordName,
		uint landlordAadhaar,

		string addressHouse,
		string typeProperty,

		uint startEpoch,
		uint endEpoch,
		uint rent){

		if(checkUser[msg.sender] == true)
		{
			var t = addressToPerson[msg.sender];
			uint num = t.myRented.length - 1;

			if(num >= 0)
			{
				uint index = t.myRented[num];

				var party = allParties[index];
				var house = allHouses[index];
				var details = allOtherDetails[index];
				var checks = allChecks[index];

				if((party.completed == true)&&(house.completed == true)&&(details.completed == true)&&(checks.paidRegisterFee = true))
				{
					address landowner = party.landlord;
					var land = addressToPerson[landowner];

					return(land.legalName, land.aadhaar, house.addressHouse, house.type_of_property, house.startEpoch,
						house.endEpoch, house.rentAmount);
				}

				else
				return('No Data', 0, 'No Data', 'No Data', 0, 0, 0);
			}

			else
			return('No Data', 0, 'No Data', 'No Data', 0, 0, 0);
		}
		else
		return('No Data', 0, 'No Data', 'No Data', 0, 0, 0);
	}

	function tenantData2() view external returns (

		uint security,
		uint registration,
		string lat,
		string long,
		uint sqFt,
		uint rooms,
		string extra ){

		if(checkUser[msg.sender] == true)
		{
			var t = addressToPerson[msg.sender];
			uint num = t.myRented.length - 1;

			if(num >= 0)
			{
				uint index = t.myRented[num];

				var party = allParties[index];
				var house = allHouses[index];
				var details = allOtherDetails[index];
				var checks = allChecks[index];

				if((party.completed == true)&&(house.completed == true)&&(details.completed == true)&&(checks.paidRegisterFee = true))
				{
					return(house.securityFee, house.registerFee, details.latitude, details.longitude, details.squareFootage,
						details.numberBedrooms, details.others);
				}

				else
				return(0, 0, '28.7041', '77.1025', 0, 0, 'No Data');
			}

			else
			return(0, 0, '28.7041', '77.1025', 0, 0, 'No Data');
		}

		else
		return(0, 0, '28.7041', '77.1025', 0, 0, 'No Data');
	}

	event rejection(string str);
	function tenantAccept(string _sign, uint _currentRate) external payable {

		require(msg.value > 0 ether);

		if(checkUser[msg.sender] == true)
		{
			var t = addressToPerson[msg.sender];
			uint num = t.myRented.length - 1;
			uint index = t.myRented[num];
			var party = allParties[index];
			var house = allHouses[index];
			var details = allOtherDetails[index];
			var checks = allChecks[index];

			if((checks.tenantCheck == true)&&(checks.tenantApprove == false))
			{
				rejection('Contract is already Rejected, draft New Contract..');
			}

			else if((party.completed == true)&&(house.completed == true)&&(details.completed == true)
				&&(checks.tenantCheck == false)&&(checks.tenantApprove == false))
			{
				checks.isValid = false;
				checks.tenantCheck = true;
				checks.tenantApprove = true;

				party.signTenant = _sign;
				checks.paidSecurityFee = true;

				rejection("Tenant Approval of Contract succesful");
			}

			else if((checks.tenantCheck == true)&&(checks.tenantApprove == true))
			{
				rejection("Contract already Approved");
			}
		}

		else
		{
			rejection("You are not registered on Tenancy..");
		}

	}


	function tenantReject(uint _currentRate) external {
		if(checkUser[msg.sender] == true)
		{
			var t = addressToPerson[msg.sender];

			uint num = t.myRented.length - 1;
			uint index = t.myRented[num];

			var party = allParties[index];
			var house = allHouses[index];
			var details = allOtherDetails[index];
			var checks = allChecks[index];

			if((party.completed == true)&&(house.completed == true)&&(details.completed == true)
				&&(checks.tenantApprove == false)&&(checks.tenantCheck == false))
			{
				checks.tenantApprove = false;
				checks.isValid = false;
				checks.tenantCheck = true;

				party.completed = false;
				house.completed = false;
				details.completed = false;

				var landowner = party.landlord; // return the registration fee back to the landlord after rejection
				landowner.transfer(house.registerFee  * 10**18/_currentRate);

				rejection("Contract Rejected, Inform Landlord to draft New Contract..");
			}

			else if((checks.tenantCheck == true)&&(checks.tenantApprove == true))
			{
				rejection("Contract already Approved");
			}

			else
			{
				rejection("Contract already Rejected, draft a New Contract");
			}
		}

		else
		{
			rejection("You are not registered on Tenancy, Register Today..");
		}
	}


	function govLogin() view external onlyOwner returns(string message, uint[] array, uint size) {
		var len = allParties.length;
		uint[] memory indexes = new uint[](len);

		uint num = 0;
		bool check = false;

		for(uint i = 0 ; i < allParties.length ; i++)
		{
			var party = allParties[i];
			var home = allHouses[i];
			var detail = allOtherDetails[i];
			var checks = allChecks[i];

			if((party.completed == true)&&(home.completed == true)&&(detail.completed == true)&&(checks.paidRegisterFee == true)&&
				(checks.paidSecurityFee == true)&&(checks.tenantApprove == true)&&(checks.tenantCheck == true)&&(checks.govApprove == false))
			{
				indexes[num] = i;
				num++;
				check = true;
			}
		}

		if(check == true)
		return('Contract Verifications Pending', indexes, num);

		else
		return('No Pending Verifications', indexes, 0);

	}


	function govApproval(uint i, uint _currentRate) external onlyOwner {
		if(i < allParties.length)
		{
			var party = allParties[i];
			var home = allHouses[i];
			var detail = allOtherDetails[i];
			var checks = allChecks[i];

			if((party.completed == true)&&(home.completed == true)&&(detail.completed == true)&&(checks.paidRegisterFee == true)&&
				(checks.paidSecurityFee == true)&&(checks.tenantApprove == true)&&(checks.tenantCheck == true))
			{
				checks.govApprove = true; // government approves
				checks.isValid = true; // marked as valid

				owner.transfer(home.registerFee * 10**18/_currentRate);
			}
		}
	}

	function govReject(uint i, uint _currentRate) external onlyOwner {
		if(i < allParties.length)
		{

			var party = allParties[i];
			var home = allHouses[i];
			var detail = allOtherDetails[i];
			var checks = allChecks[i];

			if((party.completed == true)&&(home.completed == true)&&(detail.completed == true)&&(checks.paidRegisterFee == true)&&
				(checks.paidSecurityFee == true)&&(checks.tenantApprove == true)&&(checks.tenantCheck == true))
			{
				checks.govApprove = false;
				checks.isValid = false;

				var _tenant = party.tenant;
				var _landlord = party.landlord;

				_landlord.transfer(home.registerFee  * 10**18 /_currentRate);
				_tenant.transfer(home.securityFee * 10**18/_currentRate);

				party.completed = false;
				home.completed = false;
				detail.completed = false;

			}
		}
	}
}