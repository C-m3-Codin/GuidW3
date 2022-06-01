# GUID

A user can login using either the private key or email id and password. In case of
a private key login the user is connected directly to the chain. In case of a email
id and password login the private key is fetched from Firestore and then the user is
logged in.
On connection to the chain the smart contract identifies the type of user:
• Regular User
• Publishing Institution
