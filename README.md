# Cluster Passport

Is a Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Hello, I'm building this APP, it's an
**ENTRANCE AUTHORIZATION APP**

This is an Android and iOS app that allows you to send requests to approve or deny the entry and/or exit of people to a physical facility (office, premises, house, apartment). The app is aimed at controlling the access of people or personnel.

### Group Organization

#### Physical Facilities
1. **F-CLUSTER(S)**: Shopping centers or residential centers that group sectors.
- **SECTOR(S)**: Streets, avenues, blocks or buildings within the F-Cluster that contain units.
- **UNIT(S)**: Commercial premises, offices, apartments or houses within the sector.

#### Companies or Groups of People
2. **P-CLUSTER(S)**: Companies or groups of people that group areas.
- **AREA(S)**: HR, Finance, Procurement, Production, etc., within the P-Cluster that contain units.
- **UNIT(S)**: Specific units of the company or the association of people within the area.

A P-Cluster can exist in an F-Cluster within a unit: F-Cluster(Sector(Unit(P-Cluster(Areas(Unit()))))).

### User Roles

1. **CLUSTER Administrator and Supervisor**
- Creates and edits primary groups called “CLUSTERS” with data (name, geographic location, phone(s)).
- Adds other administrator users of the "CLUSTER" group.
- Adds, modifies or deletes supervisor users within the group.
- Creates secondary subgroups called “SECTORS” or “AREAS” within the “CLUSTER” group.
- Adds at least one administrator user to the "SECTORS" or "AREAS" subgroup.
- Creates tertiary subgroups called “UNITS” within the “SECTORS” group.
- Can add users to the UNIT subgroup.
- Sends notifications of entry of visitors to the corresponding subgroup.

2. **SECTOR or AREA Administrator and Supervisor**
- Adds other group administrator users.
- Creates tertiary subgroups called “UNIT” within the “SECTOR” or “AREA” group.
- Adds at least one administrator user to the “UNIT” subgroup.
- Adds, modifies or deletes supervisor users within the group.
- Sends notifications of entry of visitors to the corresponding subgroup.

3. **Unit Administrator**
- Creates and authorizes other administrator users of his unit.
- Adds other inhabitants to the subgroup.
- Sends notifications of entry of visitors to the corresponding subgroup.

4. **Unit Resident**
- Resides in the unit with limited permissions to grant permission to enter his unit.

5. **Guard**
- Receives notifications of visitor entry and approves or denies them according to the subgroup to which they are addressed.

6. **Visitor**
- Temporary user who enters and leaves the facility.

### How the App Works

1. **User Authentication**
- Authentication in three instances: email/cell phone, personal documents (passport, license, ID), and providers (Google, Microsoft, Facebook).

2. **Contacts**
- The requesting user enters the email or phone number of the receiving user and sends a contact request notification.
- The receiving user approves or denies the contact request.

3. **Group Creation**
- When creating an F-Cluster or P-Cluster group, the user becomes an administrator and can choose administrators.
- Creates subgroups of Sectors or Areas and subgroups of Units.
- Selection of guards is mandatory.

4. **Visitor Entry Request**
- The visitor can send a message to request access to the facility.

5. **Creating Entry Authorization**
- The resident can create a new entry authorization for another user.
- The system generates an automatic code and the resident chooses the time and type of visit.

6. **Sending Authorization**
- The resident sends the authorization to the server, which stores it and sends it to the users involved.

7. **Receiving Authorization Notification**
- Users receive the notification and update their user interface.

8. **Approving/Denying Authorization**
- The visitor gives the code to the security guard for validation.
- The app validates the code and approves or denies entry.

9. **Search for Notifications**
- Search by keyword or conversation ID.

10. **Notification Deletion**
- Users can delete old notifications.

11. **User Interface Update**
- The interface updates in real time to show new notifications and changes in access status.