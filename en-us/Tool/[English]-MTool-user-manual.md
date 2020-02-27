
### Introduction

In order to facilitate node pledge, commission, and governance related operations, PlatON provides MTool to assist users.

- MTool supports Ubuntu 18.04 and Windows 10.
- MTool needs to connect to the verification node through the RPC interface. The installation and deployment of the verification node can refer to [becoming a verification node](en-us/Node/[English]-Install-Validator.md).
- To ensure node security, it is recommended that node RPC ports be accessed through Nginx proxy. Nginx uses Https and user authentication to strengthen security protection.
- MTool provides two signature methods for transactions such as pledge: online signature and offline signature.

### Application scenario

- If the user has only one online machine to send transactions directly, you can refer to the [online MTool manual](en-us/Tool/[English]-Online-MTool-user-manual.md).
- If the user conditions allow, for security reasons, you can sign transactions on offline machines, and send signed transactions by online machines, you can refer to the [offline MTool user manual](en-us/Tool/[English]-Offline-MTool-user-manual.md).