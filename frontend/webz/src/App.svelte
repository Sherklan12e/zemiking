<script>
  import { Router, Link, Route } from "svelte-routing";
  import Navbar from './components/layaout/navbar.svelte';
  import Home from './components/home.svelte';
  import Comentarios from './components/publicar/comentarios.svelte'; 
  export let url = "";
</script>

<Router {url}>
  <Navbar />
  
  <main>
    <Route path="/" component={Home} />
    <Route path="/comentarios/:movieId" component={Comentarios} />
  </main>
</Router>

<style>
  main {
    margin-top: 70px;
    padding: 2rem;
  }
</style>