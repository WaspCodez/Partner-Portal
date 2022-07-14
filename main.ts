import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router';
import { createPinia } from 'pinia'
//import App from './App.vue'
import PartnerPortalApp from './PartnerPortalApp.vue'
import ClientRegister from './components/clientRegister.vue'
import Login from './components/login.vue'
import ClientAddUser from './components/ClientAddUser.vue'
import UserRegister from './components/UserRegister.vue'
import AddUser from './components/AddUser.vue'
import Vendor from './components/Vendor.vue'


const routes = [
    { name: 'login', path: '/', component: Login },
    { name: 'clientRegister', path: '/ClientRegister', component: ClientRegister },
    { name: 'clientAddUser', path: '/ClientAddUser', component: ClientAddUser },
    { name: 'userRegister', path: '/UserRegister', component: UserRegister },
    { name: 'addUser', path: '/AddUser', component: AddUser },
    { name: 'vendor', path: '/Vendor/:id', component: Vendor, props: true }
];

const router = createRouter({
    history: createWebHistory(),
    routes // short for routes:routes

});
//createApp(App).mount('#app')
createApp(PartnerPortalApp)
    .use(router)
    .use(createPinia())
    .mount('#app')
