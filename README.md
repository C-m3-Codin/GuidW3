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
 ![picture alt](https://github.com/C-m3-Codin/GuidW3/blob/main/images/EntireAlgorithm.jpeg?raw=true "Algo ")

If an institute tags a secondary institute as a associate in the certificate the secondary
institute would be required to approve the certificate as a legitimate one by signing
it as well.

<h3> Verification of Certificate publishing Institutions</h3>
<p>
 Initially when the contract is being deployed there would be 4 main node that would
be approved and verified as Institutes that can publish verified certificates. Broadly
these four institutes would be the root institutes publishing certificates in different
categories.
 </br>
 
 <img src = "https://github.com/C-m3-Codin/GuidW3/blob/main/images/certificateStruct.PNG?raw=true">
 </br>
 These Institute would be given rights to approve the Institute status of a different
newly registered Institute account. Once a new Institute has been registered, it can
be approved a ”verified” by a already ”verified” Institute account. This provides
a method where one can trace back fault in case of emergence of fake institutes
publishing certificates.
</p>

<h3> Deploy a contract for verification of certificates on
chain</h3>
<p>
 While publishing a certificate the publishing Institute has option to select if this certificate has been published in association with other institute. For this the Institute
publishing the certificate has to tag other Institutes while publishing the certificate.
The tag needs to be authorised and signed by the tagged institute for it to be valid
tag.
 </p>
 <img src = "https://github.com/C-m3-Codin/GuidW3/blob/main/images/verification.jpeg?raw=true">
<p>
Once an Institute tags a different Institute in the certificate published the tagged
institution gets a notification regarding the tag. The tagged Institute in the home
page would get option to approve the tag so as to certify that the tag is official.
On the certificate there would be indication to flag if the tagged institution has
approved the tag or if is still in the verification process or if it has been denied
approval. This feature makes sure one Institute does not fraudulently associate
itself with a different legitimate institute in its certificate
</p>
<!-- <details>
           <summary>Title 1</summary>
           <p>Content 1 Content 1 Content 1 Content 1 Content 1</p>
</details> -->
