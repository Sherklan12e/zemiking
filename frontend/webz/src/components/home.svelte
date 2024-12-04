<script>
  import { onMount } from 'svelte';
  import gloglo from '../images/gloglo.png';
  import Comentarios from './publicar/comentarios.svelte';

  let items = [];
  let loading = true;
  let error = null;

  onMount(async () => {
    try {
      const response = await fetch('http://localhost:3000/api');
      items = await response.json();
    } catch (e) {
      error = 'Error al cargar los datos';
    } finally {
      loading = false;
    }
  });
</script>

<div class="home-container">
  <!-- Sección principal con la imagen y cards -->
  <section class="main-content">
    {#if loading}
      <div class="loading">Cargando contenido...</div>
    {:else if error}
      <div class="error">{error}</div>
    {:else}
      <div class="content-layout">
        <!-- Cards izquierdas -->
        <div class="cards-left">
          {#each items.slice(0, 2) as item}
            <div class="card">
              {#if item.image_url}
                <img src={`http://localhost:3000/${item.image_url}`} alt={item.name} />
              {/if}
              <div class="card-content">
                <h2>{item.title}</h2>
                {#if item.link}
                  <a href={item.link} target="_blank" rel="noopener noreferrer" class="btn">
                    Ver más
                  </a>
                {/if}
              </div>
            </div>
          {/each}
        </div>

        <!-- Imagen central -->
        <div class="center-image">
          <img src={gloglo} alt="Gloglo" class="gloglo-image" />
        </div>

        <!-- Cards derechas -->
        <div class="cards-right">
          {#each items.slice(2, 4) as item}
            <div class="card">
              {#if item.image_url}
                <img src={`http://localhost:3000/${item.image_url}`} alt={item.title} />
                {console.log(`http://localhost:3000/${item.image_url}`)}
              {/if}
              <div class="card-content">
                <h2>{item.title}</h2>
                {#if item.link}
                  <a href={item.link} target="_blank" rel="noopener noreferrer" class="btn">
                    Ver más
                  </a>
                {/if}
              </div>
            </div>
          {/each}
        </div>
      </div>
    {/if}
  </section>

  <!-- Sección de comentarios -->
   <!-- Sección de comentarios -->
   <section class="comments-section" id="comentarios">
    <div class="section-divider"></div>
    <div class="comments-wrapper">
      <Comentarios />
    </div>
  </section>
</div>

<style>
  .home-container {
    width: 100%;
    max-width: 1400px;
    margin: 0 auto;
    padding: 2rem;
    display: flex;
    flex-direction: column;
    gap: 4rem;
  }

  .main-content {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .comments-section {
    min-height: 100vh;
    padding: 2rem 0;
  }

  .section-divider {
    height: 3px;
    background: linear-gradient(to right, transparent, #0fb8e2, transparent);
    margin: 4rem 0;
    opacity: 0.2;
  }

  .content-layout {
    display: grid;
    grid-template-columns: 1fr auto 1fr;
    gap: 2rem;
    align-items: center;
  }

  .center-image {
    padding: 2rem;
  }

  .gloglo-image {
    width: 500px;
    height: 700px;
    object-fit: contain;
  }

  .cards-left, .cards-right {
    display: flex;
    flex-direction: column;
    gap: 2rem;
  }

  .card {
    background: rgba(255, 255, 255, 0);
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    animation: float 2s ease-in-out infinite;
  }

  .card:hover {
    transform: translateY(-15px);
    animation-play-state: paused;
  }

  .card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
  }

  .card-content {
    padding: 1.5rem;
  }

  .card h2 {
    margin: 0 0 1rem 0;
    font-size: 1.8rem;
    color: #333;
    font-family: 'Playfair Display', serif;
    font-weight: 600;
    line-height: 1.2;
  }

  .btn {
    display: inline-block;
    padding: 0.8rem 1.5rem;
    background: #0899ee;
    color: white;
    text-decoration: none;
    border-radius: 8px;
    transition: all 0.3s ease;
    font-weight: 500;
    letter-spacing: 0.5px;
    font-size: 0.95rem;
  }

  .btn:hover {
    background: #00a2ff;
  }

  .loading {
    text-align: center;
    padding: 2rem;
    font-size: 1.3rem;
    color: #666;
    font-weight: 300;
    letter-spacing: 0.5px;
  }

  .error {
    text-align: center;
    padding: 2rem;
    color: #ff3e00;
    font-size: 1.2rem;
  }

  @media (max-width: 1200px) {
    .content-layout {
      grid-template-columns: 1fr;
      grid-template-rows: auto auto auto;
    }

    .gloglo-image {
      width: 100%;
      max-width: 500px;
      height: auto;
      margin: 0 auto;
    }

    .cards-left, .cards-right {
      flex-direction: row;
      flex-wrap: wrap;
      justify-content: center;
    }

    .card {
      width: calc(50% - 1rem);
    }
  }

  @media (max-width: 768px) {
    .card {
      width: 100%;
    }

    .home-container {
      padding: 1rem;
      gap: 2rem;
    }

    .main-content, .comments-section {
      min-height: auto;
    }
  }

  @keyframes float {
    0% {
      transform: translateY(0px);
    }
    50% {
      transform: translateY(-10px);
    }
    100% {
      transform: translateY(0px);
    }
  }

  .cards-left .card:nth-child(1) {
    animation-delay: 0s;
  }
  .cards-left .card:nth-child(2) {
    animation-delay: 0.5s;
  }
  .cards-right .card:nth-child(1) {
    animation-delay: 1s;
  }
  .cards-right .card:nth-child(2) {
    animation-delay: 1.5s;
  }

  .comments-wrapper {
    background:white;
    border-radius: 24px;
    padding: 3rem 1rem;
    margin-top: 2rem;
    box-shadow: 0 4px 30px rgba(0,0,0,0.1);
  }
</style>
