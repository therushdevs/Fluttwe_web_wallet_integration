// web/meta_mask.js

window.connectMetaMask = async () => {
  if (window.ethereum) {
    try {
      // Request account access
      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      console.log("Connected MetaMask Account:", accounts[0]);
      return accounts[0];
    } catch (error) {
      console.error("User rejected the request or there was an error:", error);
      return null;
    }
  } else {
    console.error("MetaMask is not installed");
    return null;
  }
};
