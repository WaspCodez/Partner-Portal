<script setup lang="ts">
import { ref } from 'vue'

defineProps<{ msg: string }>()

const count = ref(0)
</script>

<template>
<h1>Login</h1>
<p> Hello HelloWorld</p>
<p>Testing</p>

</template>

<style>
a {
  color: #42b983;
}
</style>