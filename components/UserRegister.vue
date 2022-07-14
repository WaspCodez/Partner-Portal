<script setup lang="ts">
import LoginRepo from '../Repos/LoginRepo';
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router';
import { useUserStore } from '../store/useUserStore';
import Users from '../models/Users';


const router = useRouter();
const store = useUserStore();

let modalUsername = ref<string>('');
let modaluserId = ref<number>();
let modalDisplayName = ref<string>('');
let modalEmail = ref<string>('');
let modalPassword = ref<string>('');
let searchloginusername = ref<string>('');


interface User_Details {
  id: number,
  username: string,
  email: string,
  password: string,
  //   time_of_login:Date,
  display_name: string,
  //   partner_id:number
}

let UserDetails = ref<User_Details[]>([]);

onMounted(async () => {

  await getUserByPartnerId();
  // Get the modal
  var modal = document.getElementById('id01');

  // When the user clicks anywhere outside of the modal, close it
  modal.style.display = "none";
})

async function getUserByPartnerId() {
  UserDetails.value = await LoginRepo.getLoginUser();
  console.log(UserDetails.value)
}



function showModal(userId: number, userName: string, userDisplayName: string, userEmail: string, userPassword: string) {
  // Get the modal
  var modal = document.getElementById('id01');

  // When the user clicks anywhere outside of the modal, close it
  modal.style.display = "block";
  //Edit clientname

  modaluserId.value = userId;
  modalUsername.value = userName;
  modalDisplayName.value = userDisplayName;
  modalEmail.value = userEmail;
  modalPassword.value = userPassword;
}

async function editUser() {

  try {
    let users: Users = {
      id: modaluserId.value,
      username: modalUsername.value,
      display_name: modalDisplayName.value,
      email: modalEmail.value,
      password: modalPassword.value

    };
    await LoginRepo.editUserById(users)
    await getUserByPartnerId();
    alert("User Has been Edited")
  }
  catch (error) {
    alert("User Has NOT! been Edited")
  }
}

async function deleteUser(userId: number) {
  try {
    await LoginRepo.deleteUserByID(userId)
    alert("deleted")
    await getUserByPartnerId();
  }
  catch (error) {
    console.log("User Not deleted" + error)
  }

}

function addclient() {

  router.push('clientAddUser')
}

function userRegister() {
  router.push('userRegister')
}

function addUserNav() {
  router.push('addUser')
}

function clientRegister() {
  router.push('clientRegister')
}

function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

/* Set the width of the side navigation to 0 */
function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}

async function search(){
 UserDetails.value = await LoginRepo.searchUser(searchloginusername.value);

 if(UserDetails.value.length <= 0){
  alert('Username not found')
 searchloginusername.value="";
   await  getUserByPartnerId();
 }

}

async function cancelsearch(){
  
   await  getUserByPartnerId();
   searchloginusername.value= "";
}
</script>

<template>

  <div id="id01" class="modal">
    <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">×</span>

    <form class="modal-content" action="/action_page.php">
      <div class="container">
        <h1 style="color:black">Edit User</h1>


        <div class="editModal">

          <div id="DivTextBoxes">
            <input type="hidden" v-model="modaluserId" />
            <img src="../assets/user.png" id="usericon" />
            <input type="text" placeholder="username" class="textboxes" v-model="modalUsername" />
          </div>

          <div id="DivTextBoxes">
            <input type="text" placeholder="Display Name" class="textboxes" v-model="modalDisplayName" />
          </div>

          <div id="DivTextBoxes">
            <input type="text" placeholder="Email " class="textboxes" v-model="modalEmail" />
          </div>

          <div id="DivTextBoxes">
            <img src="../assets/lock.png" id="usericon" />
            <input type="text" placeholder="Password " class="textboxes" v-model="modalPassword" />
          </div>

          <button type="button" onclick="document.getElementById('id01').style.display='none'"
            class="bn632-hover bn28">Cancel</button>
          <button type="button" class="bn632-hover bn22" @click="editUser()">Edit</button>
        </div>
      </div>
    </form>
  </div>

  <div id="mySidenav" class="sidenav">
    <a href="javascript:void(0)" class="closebtn" @click="closeNav()">&times;</a>
    <a href="#" @click="clientRegister()">Client Register</a>
    <a href="#" @click="userRegister()">View Users</a>
    <a href="#" @click="addclient">Add Client</a>
    <a href="#" @click="addUserNav()">Add User </a>
  </div>


  <!-- Use any element to open the sidenav -->
  <span @click="openNav()">☰ Menu</span>

  <h1 class="adduserHeading">User Regiser</h1>
   
   <div> 
      <div id="DivTxtBoxes">
        <img src="../assets/search.png" id="usericon"/>
        <input type="text" placeholder="Search by User Name" class="textboxes" v-model="searchloginusername"/> <button class="xbutton" @click="cancelsearch">x</button>
         <button class="searchbutton" @click="search"> Search</button>
      </div>
     
     </div> 

  <div class="usertbl" style="height:20px">
    <table>
      <thead>
        <tr>
          
          <th>User ID</th>
          <th>User Name</th>
          <th>User Display Name</th>
          <th>Email</th>
          <th>Password</th>
          <th></th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="userdetails in UserDetails">
         
          <td> {{ userdetails.id }}</td>
          <td>{{ userdetails.username }}</td>
          <td>{{ userdetails.display_name }}</td>
          <td>{{ userdetails.email }} </td>
          <td> {{ userdetails.password }}</td>
           <td><button @click="deleteUser(userdetails.id)" class="bn632-hover bn28">Delete</button></td>
          <td><button
              @click="showModal(userdetails.id, userdetails.username, userdetails.display_name, userdetails.email, userdetails.password)"
              class="bn632-hover bn20">Edit</button></td>

        </tr>
      </tbody>
    </table>
  </div>
</template>

<style>
.modal {
  border-radius: 25px;
  padding: 0px;
  margin: 0;
  background-color: rgb(197, 208, 255);
}

.adduserHeading {
  color: black;
  font-size: 50px;
}

td {
  border-bottom: 1px solid black;
}


.editModal {
  height: 50%;
  background-color: rgb(197, 208, 255);

}

.container {
  background-color: rgb(197, 208, 255);
  border: none;

}

.bn632-hover {
  width: 160px;
  font-size: 16px;
  font-weight: 600;
  color: #fff;
  cursor: pointer;
  margin: 20px;
  height: 55px;
  text-align: center;
  border: none;
  background-size: 300% 100%;
  border-radius: 50px;
  moz-transition: all .4s ease-in-out;
  -o-transition: all .4s ease-in-out;
  -webkit-transition: all .4s ease-in-out;
  transition: all .4s ease-in-out;
}

.bn632-hover:hover {
  background-position: 100% 0;
  moz-transition: all .4s ease-in-out;
  -o-transition: all .4s ease-in-out;
  -webkit-transition: all .4s ease-in-out;
  transition: all .4s ease-in-out;
}

.bn632-hover:focus {
  outline: none;
}

.bn632-hover.bn22 {
  background-image: linear-gradient(to right,
      #0ba360,
      #3cba92,
      #30dd8a,
      #2bb673);
  box-shadow: 0 4px 15px 0 rgba(23, 168, 108, 0.75);
}

/* width */
::-webkit-scrollbar {
  width: 20px;
}

/* Track */
::-webkit-scrollbar-track {
  box-shadow: inset 0 0 5px grey;
  border-radius: 10px;
}

/* Handle */
::-webkit-scrollbar-thumb {
  background: lavender;
  border-radius: 10px;
}
</style>