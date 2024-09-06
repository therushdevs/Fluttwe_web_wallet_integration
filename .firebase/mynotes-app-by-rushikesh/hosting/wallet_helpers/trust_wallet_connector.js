var walletConnector;

function isTrustWalletInstalled() {
  // Check if window.ethereum is defined
  if (typeof window.ethereum !== "undefined") {
    // Optionally, check for Trust Wallet specific property or method
    // For Trust Wallet, you might not find a specific flag like 'isTrust'
    return (
      window.ethereum.isTrust ||
      window.ethereum.isTrustWallet ||
      window.ethereum.isTrustWalletExtension
    );
  }
  return false;
}

async function connectTrustWallet() {
  const WalletConnect = window.WalletConnect.default;
  const WalletConnectQRCodeModal = window.WalletConnectQRCodeModal.default;
  walletConnector = new WalletConnect({
    bridge: "https://bridge.walletconnect.org", // Required bridge
    qrcodeModal: WalletConnectQRCodeModal, // Modal for displaying QR code
  });

  // Check if already connected
  if (!walletConnector.connected) {
    // Create a new session
    await walletConnector.createSession();
  }

  // Listen for connection event
  walletConnector.on("connect", (error, payload) => {
    if (error) {
      throw new Error(`Error: ${error}`);
    }

    // Get provided accounts and chainId
    const { accounts, chainId } = payload.params[0];
    return accounts[0]; // Return the first account (public key)
  });

  // Listen for disconnection event
  walletConnector.on("disconnect", (error, payload) => {
    if (error) {
      throw new Error(`Error: ${error}`);
    }

    console.log("Disconnected");
  });
}

function getConnectedAccount() {
  if (walletConnector && walletConnector.connected) {
    return walletConnector.accounts[0];
  } else {
    throw new Error("Cannot get the key, something went wrong");
  }
}

function disconnectTrustWallet() {
  if (walletConnector && walletConnector.connected) {
    walletConnector.killSession();
    console.log("Session disconnected");
  }
}
