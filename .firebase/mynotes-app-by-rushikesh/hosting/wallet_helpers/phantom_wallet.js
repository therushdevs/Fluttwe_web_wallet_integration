// Function to check if Phantom Wallet is installed
function isPhantomInstalled() {
  return window.solana && window.solana.isPhantom;
}

// Function to connect Phantom Wallet
async function connectPhantom() {
  if (window.solana) {
    try {
      const resp = await window.solana.connect();
      return resp.publicKey.toString(); // Return the public key of the wallet
    } catch (err) {
      console.error("Error connecting to Phantom Wallet:", err);
      throw new Error("Error connecting to Phantom Wallet:", err);
    }
  } else {
    throw new Error("Cannot find Phantom Wallet installation");
  }
}

// Function to get the connected Phantom Wallet's public key
function getPhantomPublicKey() {
  if (window.solana && window.solana.isConnected && window.solana.publicKey) {
    return window.solana.publicKey.toString();
  } else {
    throw new Error("Cannot get the key, something went wrong");
  }
}
