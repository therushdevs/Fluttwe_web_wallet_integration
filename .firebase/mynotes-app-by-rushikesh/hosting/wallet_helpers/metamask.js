function isMetaMaskInstalled() {
  return typeof window.ethereum !== "undefined" && window.ethereum.isMetaMask;
}

async function connectMetaMask() {
  if (window.ethereum) {
    try {
      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      return accounts[0];
    } catch (error) {
      console.error("Error connecting to MetaMask:", error);
      throw {
        message: `Error connecting to MetaMask: ${error.message}`,
        code: error.code,
      };
    }
  } else {
    console.error("MetaMask not found!");
    // throw new Error("MetaMask not found!");
    throw { message: "MetaMask not found!", code: "NO_METAMASK" };
  }
}

// Function to get the current MetaMask account
function getMetaMaskAccount() {
  if (window.ethereum && window.ethereum.selectedAddress) {
    return window.ethereum.selectedAddress;
  } else {
    throw new Error("Sorry!! Cannot get current Metamask Account");
  }
}
