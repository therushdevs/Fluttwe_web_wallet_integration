async function connectMetaMask() {
  if (window.ethereum) {
    try {
      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      return accounts[0]; // Return the first account (user's Ethereum address)
    } catch (error) {
      console.error("Error connecting to MetaMask:", error);
      return null;
    }
  } else {
    console.error("MetaMask not found!");
    return null;
  }
}

// Function to get the current MetaMask account
function getMetaMaskAccount() {
  if (window.ethereum) {
    return window.ethereum.selectedAddress;
  } else {
    return null;
  }
}
