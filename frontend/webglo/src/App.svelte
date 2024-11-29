<script>
  import { Router, Link, Route } from "svelte-routing";
  import Home from "./components/Home.svelte";
  import Login from "./components/Login.svelte";
  import { isAuthenticated } from './stores/auth';

  export let url = "";
</script>

<Router {url}>
  <nav>
    {#if $isAuthenticated}
      <Link to="/">Home</Link>
      <button on:click={() => {
        isAuthenticated.set(false);
        localStorage.removeItem('isAdmin');
      }}>Cerrar Sesión</button>
    {/if}
  </nav>

  <main>
    <Route path="/" component={$isAuthenticated ? Home : Login} />
  </main>
</Router>

<style>
  nav {
    padding: 1rem;
    background: #f5f5f5;
  }
  
  nav :global(a) {
    color: #333;
    text-decoration: none;
    margin-right: 1rem;
  }
  
  main {
    padding: 2rem;
  }
</style>
