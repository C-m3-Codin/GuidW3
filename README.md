# GUID

A user can login using either the private key or email id and password. In case of
a private key login the user is connected directly to the chain. In case of a email
id and password login the private key is fetched from Firestore and then the user is
logged in.
On connection to the chain the smart contract identifies the type of user:

1. Regular User

2. Institution

A regular user has the option to view certificates published against him/her and add
or modify access control to each of the certificates published against him.
An institution account has the ability to publish certificates against a public address. While publishing the certificate the institute can specify the access control
to the particular address. The certificates can be either public or private. Private
certificates require the institute to mention who can view the certificate. The viewer
is identified by the public address of the user. Institute account can also tag other
Institute accounts if the certificates is published in association with a secondary
Institution.

 ## Flow Diagram ##
 

If an institute tags a secondary institute as a associate in the certificate the secondary
institute would be required to approve the certificate as a legitimate one by signing
it as well.

<!-- <details>
           <summary>Title 1</summary>
           <p>Content 1 Content 1 Content 1 Content 1 Content 1</p>
</details> -->
