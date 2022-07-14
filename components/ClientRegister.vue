<script setup lang="ts">
import ClientRepo from '../Repos/ClientRepo';
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router';
import { useUserStore } from '../store/useUserStore';
import ClientRepos from '../Repos/ClientRepos';
import Client from '../models/Client';

const router = useRouter();
const store = useUserStore();

let modalUsername = ref<string>('');
let modalClientId = ref<number>();
let searchclientname = ref<string>('');

interface Client_Details {
  id: number,
  name: string
}

let clientDetails = ref<Client_Details[]>([]);


onMounted(async () => {
  await getClientsByOPartnerId();

  // Get the modal
  var modal = document.getElementById('id01');

  // When the user clicks anywhere outside of the modal, close it
  modal.style.display = "none";

})

async function getClientsByOPartnerId() {
  clientDetails.value = await ClientRepo.getClientsByPartnerId();
  let cl = clientDetails.value.length;
  console.log(cl)
  console.log(clientDetails.value)

}

function addclient() {

  router.push('clientAddUser')
}

function userRegister() {
  router.push('userRegister')
}

function addUser() {
  router.push('addUser')
}

function clientRegister() {
  router.push('clientRegister')
}

async function deleteClient(clientId: number) {

  try {
    console.log(clientId)
    await ClientRepos.deleteClientById(clientId)
    alert("deleted")
     closeNav();
    await getClientsByOPartnerId();
  } catch (error) {
    console.log(error)
  }

}

function showModal(clientId: number, Clientname: string) {
  // Get the modal
  var modal = document.getElementById('id01');

  // When the user clicks anywhere outside of the modal, close it
  modal.style.display = "block";
  //Edit clientname

  modalUsername.value = Clientname;
  modalClientId.value = clientId;


}

async function editClient() {
  try {
    let client: Client = {
      id: modalClientId.value,
      name: modalUsername.value
    };
    await ClientRepos.editClientById(client)
    await getClientsByOPartnerId();
    closeNav();
    alert("Client Has been Edited")
  } catch (error) {

  }
}


/* Set the width of the side navigation to 250px */
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

/* Set the width of the side navigation to 0 */
function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}

function openVendor(clientid: number) {
  router.push({
    name: "vendor",
    params: {
      id: clientid
    }
  })
}

async function search(){
 clientDetails.value = await ClientRepos.searchClientByUsername(searchclientname.value);

 if(clientDetails.value.length <= 0){
  alert('Username not found')
  searchclientname.value="";
   await getClientsByOPartnerId();
 }

}

async function cancelsearch(){
  
   await getClientsByOPartnerId();
   searchclientname.value= "";
}
</script>

<template>
  <!-- Use any element to open the sidenav -->
  <span @click="openNav()" class="bn632-hover bn20">☰ Menu</span>

  <body id="clientbody">
    <div id="id01" class="modal">
      <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">×</span>

      <form class="modal-content" action="/action_page.php">
        <div class="container">
          <h1 style="color:black">Edit Client</h1>


          <div class="clearfix">

            <div id="DivTextBoxes">
              <img src="../assets/user.png" id="usericon" />
              <input type="hidden" v-model="modalClientId" />
              <input type="text" placeholder="username" class="textboxes" v-model="modalUsername" />
            </div>
            <button type="button" onclick="document.getElementById('id01').style.display='none'"
              class="bn632-hover bn28">Cancel</button>
            <button type="button" class="bn632-hover bn20" @click="editClient()">Edit</button>
          </div>
        </div>
      </form>
    </div>

    <div class="welcomeHeader">

      <img src="../assets/headerimage.png" alt="turning profile" class="headerimage" />
      <h1>Welcome... </h1>
      <h1 class="clientregisterHeader">Client Register</h1>
    </div>

    <div id="mySidenav" class="sidenav">
      <a href="javascript:void(0)" class="closebtn" @click="closeNav()">&times;</a>
      <a href="#" @click="clientRegister()">Client Register</a>
      <a href="#" @click="userRegister()">View Users</a>
      <a href="#" @click="addclient">Add Client</a>
      <a href="#" @click="addUser()">Add User </a>
    </div>

    <h1></h1>
     <div> 
      <div id="DivTxtBoxes">
        <img src="../assets/search.png" id="usericon"/>
        <input type="text" placeholder="Search by Client Name" class="textboxes" v-model="searchclientname"/> <button class="xbutton" @click="cancelsearch">x</button>
         <button class="searchbutton" @click="search"> Search</button>
      </div>
     
     </div> 
    <div>
      <table>
        <thead>
          <tr>
            

            <th>Client ID</th>
            <th>Client Username</th>

            <th></th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="clientdetails in clientDetails">
           
            <td> {{ clientdetails.id }}</td>
            <td>{{ clientdetails.name }}</td>

             <td><button @click="deleteClient(clientdetails.id)" class="bn632-hover bn28">Delete</button></td>
            <td>
              <div class="dropdown">
                <button class="bn632-hover bn20">☰</button>
                <div class="dropdown-content">
                  <a href="#" @click="showModal(clientdetails.id, clientdetails.name)">Edit </a>
                  <a href="#" @click="openVendor(clientdetails.id)">View Vendors</a>
                </div>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>


  </body>


</template>

<style>
body {}

/* The side navigation menu */
.sidenav {
  height: 100%;
  /* 100% Full-height */
  width: 0;
  /* 0 width - change this with JavaScript */
  position: fixed;
  /* Stay in place */
  z-index: 1;
  /* Stay on top */
  top: 0;
  /* Stay at the top */
  left: 0;
  /* background-color: #111; Black */
  background: linear-gradient(-45deg, #5290ee, #ab87ec, lavender, #23d5ab);
  background-size: 400% 400%;
  animation: gradient 15s ease infinite;
  height: 100vh;
  overflow-x: hidden;
  /* Disable horizontal scroll */
  padding-top: 60px;
  /* Place content 60px from the top */
  transition: 0.5s;
  /* 0.5 second transition effect to slide in the sidenav */
}

@keyframes gradient {
  0% {
    background-position: 0% 50%;
  }

  50% {
    background-position: 100% 50%;
  }

  100% {
    background-position: 0% 50%;
  }

}

/* The navigation menu links */
.sidenav a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 25px;
  color: #818181;
  display: block;
  transition: 0.3s;
}

/* When you mouse over the navigation links, change their color */
.sidenav a:hover {
  color: #f1f1f1;
}

/* Position and style the close button (top right corner) */
.sidenav .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}

/* Style page content - use this if you want to push the page content to the right when you open the side navigation */
#main {
  transition: margin-left .5s;
  padding: 20px;
}

/* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
@media screen and (max-height: 450px) {
  .sidenav {
    padding-top: 15px;
  }

  .sidenav a {
    font-size: 18px;
  }
}

span {
  float: left;
  cursor: pointer;
  border-radius: 25px;
  background-color: rgba(89, 91, 241, 0.247);
  /* padding: 10px; */
  top: 0;

}

.welcomeHeader {
  height: 25%;
  width: 85%;
  color: dark blue;
  /* position: fixed; */

  z-index: 0;
  top: 1px;
  margin-left: 210px;
  background: linear-gradient(-45deg, #5290ee, #ab87ec, lavender, #cffff4);
  animation: gradient 20s ease infinite;
  border-radius: 25px;
}

@keyframes gradient {
  0% {
    background-position: 0% 50%;
  }

  50% {
    background-position: 100% 50%;
  }

  100% {
    background-position: 0% 50%;
  }

}

table {

  /* margin-top:250px; */
  width: 85%;
  height: 50%;
  border-radius: 25px;
  padding: 20px;
  background-color: lavender;
  overflow-y: scroll;

}

.rotatinghead {
  width: 90%;
  height: 90%;
}

/* Set a style for all buttons */
.cancelbtn,
.deletebtn {
  background-color: #04AA6D;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
  opacity: 0.9;
  margin-top: 50%;
}

button:hover {
  opacity: 1;
}

/* Float cancel and delete buttons and add an equal width */
.cancelbtn,
.deletebtn {
  float: left;
  width: 50%;
}

/* Add a color to the cancel button */
.cancelbtn {
  background-color: #ccc;
  color: black;
}

/* Add a color to the delete button */
.deletebtn {
  background-color: #0aaf3b;
}

/* Add padding and center-align text to the container */
.container {
  padding: 16px;
  text-align: center;
}

/* The Modal (background) */
.modal {
  display: none;
  /* Hidden by default */
  position: fixed;
  /* Stay in place */
  z-index: 1;
  /* Sit on top */
  left: 15%;
  top: 20%;
  width: 80%;
  /* Full width */
  height: auto;
  /* Full height */
  overflow: auto;
  /* Enable scroll if needed */
  background-color: #ffffff;
  padding-top: 50px;
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  margin: 5% auto 15% auto;
  /* 5% from the top, 15% from the bottom and centered */
  border: 1px solid #888;
  width: 80%;
  /* Could be more or less, depending on screen size */
}

/* Style the horizontal ruler */
hr {
  border: 1px solid #f1f1f1;
  margin-bottom: 25px;
}

/* The Modal Close Button (x) */
.close {
  position: absolute;
  right: 35px;
  top: 15px;
  font-size: 40px;
  font-weight: bold;
  color: #f1f1f1;
}

.close:hover,
.close:focus {
  color: #f44336;
  cursor: pointer;
}

/* Clear floats */
.clearfix::after {
  content: "";
  clear: both;
  display: table;
}

/* Change styles for cancel button and delete button on extra small screens */
@media screen and (max-width: 300px) {

  .cancelbtn,
  .deletebtn {
    width: 100%;
  }
}

.textboxes {

  height: 30px;
  width: 80%;
  border: 0;
  outline-style: none;
  background-color: rgb(228, 228, 228);

  color: gray;

}

#DivTextBoxes {

  padding-top: 5px;
  margin-top: 10px;
  height: 40px;
  width: 100%;
  border-radius: 25px;
  background-color: rgb(228, 228, 228);

}

td {
  width: 15%;
}

.headerimage {
  width: 200px;
  height: 200px;
  float: left;
}

.clientregisterHeader {
  font-size: 70px;
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

.bn632-hover.bn28 {
  background-image: linear-gradient(to right,
      #eb3941,
      #f15e64,
      #e14e53,
      #e2373f);
  box-shadow: 0 5px 15px rgba(242, 97, 103, 0.4);
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

.bn632-hover.bn20 {
  background-image: linear-gradient(to right,
      #667eea,
      #764ba2,
      #6b8dd6,
      #8e37d7);
  box-shadow: 0 4px 15px 0 rgba(116, 79, 168, 0.75);
}

.dropbtn {
  background-color: #04AA6D;
  color: white;
  padding: 16px;
  font-size: 16px;
  border: none;
}

/* The container <div> - needed to position the dropdown content */
.dropdown {
  position: relative;
  display: inline-block;
}

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
  display: none;
  position: absolute;

  background-color: #f1f1f1;
  min-width: 190px;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  z-index: 1;
}

/* Links inside the dropdown */
.dropdown-content a {
  color: black;
  padding: 20px;
  text-decoration: none;
  display: block;
  background-color: lavender;
  text-align: left;
}

/* Change color of dropdown links on hover */
.dropdown-content a:hover {

  border: 1px black solid;
  border-radius: 25px;
}

/* Show the dropdown menu on hover */
.dropdown:hover .dropdown-content {
  display: block;
}

/* Change the background color of the dropdown button when the dropdown content is shown */
.dropdown:hover .dropbtn {
  background-color: #3e8e41;
}

#DivTxtBoxes{
   padding-top: 5px;
  margin-top: 10px;
  margin-bottom: 10px;
  padding-left: 10px;
  height: 45px;
  width: 50%;
  border-radius: 25px;
  background-color: rgb(228, 228, 228);
  border-right: -25px;
 margin-left:30%;
}

.searchbutton{
    /* padding-top: 5px;
    padding-bottom: 15px;
    padding-left:15px;
    padding-right:30px; */
 
    padding:10px;
  height: 32px;
  border-radius: 25px;
  outline:none;
  border: none;
  color:white;

   background-image: linear-gradient(to right,
      #667eea,
      #764ba2,
      #6b8dd6,
      #8e37d7);
  box-shadow: 0 4px 15px 0 rgba(116, 79, 168, 0.75);
  
}

.searchbutton:hover{
  background-image: linear-gradient(to left,
      #667eea,
      #764ba2,
      #6b8dd6,
      #8e37d7);
  box-shadow: 0 4px 15px 0 rgba(116, 79, 168, 0.75);
}

.xbutton{
  margin-right: 5px;
  background-color: red;
  color:white;
  border:none;
  border-radius: 50px;
}

.xbutton:hover{
 background-color: rgb(199, 111, 111);
  color:white;
}
</style>