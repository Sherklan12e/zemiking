<script>
  import { onMount } from 'svelte';
  import { fade, fly } from 'svelte/transition';

  let comments = [];
  let newComment = {
    name: '',
    comment: ''
  };
  let loading = false;
  let error = null;

  async function loadComments() {
    try {
      const response = await fetch('http://localhost:3000/comments/');
      const data = await response.json();
      comments = data;
    } catch (e) {
      error = 'Error al cargar los comentarios';
    }
  }

  async function handleSubmit() {
    if (!newComment.comment.trim()) return;
    loading = true;
    try {
      const response = await fetch('http://localhost:3000/comments', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(newComment)
      });

      if (response.ok) {
        newComment.name = '';
        newComment.comment = '';
        await loadComments();
      }
    } catch (e) {
      error = 'Error al publicar el comentario';
    } finally {
      loading = false;
    }
  }

  onMount(loadComments);
</script>

<div class="comments-container" in:fade={{duration: 800}}>
  <h2 class="title">Comentarios de la Comunidad</h2>
  
  <form on:submit|preventDefault={handleSubmit} class="comment-form" in:fly={{y: 50, duration: 800}}>
    <div class="form-group">
      <input
        type="text"
        placeholder="Tu nombre (opcional)"
        bind:value={newComment.name}
        class="input-field"
      >
    </div>
    <div class="form-group">
      <textarea
        placeholder="Comparte tus pensamientos..."
        bind:value={newComment.comment}
        required
        class="textarea-field"
      ></textarea>
    </div>
    <button type="submit" disabled={loading} class="submit-button">
      {loading ? '✨ Publicando...' : '✨ Compartir comentario'}
    </button>
  </form>

  {#if error}
    <div class="error" in:fade>{error}</div>
  {/if}

  <div class="comments-list">
    {#each comments as comment, i}
      <div 
        class="comment"
        in:fly={{y: 50, delay: i * 100, duration: 500}}
      >
        <div class="comment-header">
          <div class="user-info">
            <span class="user-avatar">{comment.name[0]?.toUpperCase() || '?'}</span>
            <strong class="user-name">{comment.name || 'Anónimo'}</strong>
          </div>
          <span class="date">{new Date(comment.created_at).toLocaleDateString()}</span>
        </div>
        <p class="comment-text">{comment.comment}</p>
      </div>
    {/each}
  </div>
</div>

<style>
  .comments-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 2rem;
  }

  .title {
    font-size: 3rem;
    color: #333;
    text-align: center;
    margin-bottom: 2.5rem;
    font-family:   Verdana, Geneva, Tahoma, sans-serif;
    font-weight: 700;
    line-height: 1.2;
    letter-spacing: -0.5px;
  }

  .comment-form {
    background: rgba(238, 5, 5, 0);
    padding: 2rem;
    border-radius: 16px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    margin-bottom: 3rem;
  }

  .form-group {
    margin-bottom: 1.5rem;
  }

  .input-field, .textarea-field {
    width: 100%;
    padding: 1rem;
    border: 2px solid #eee;
    border-radius: 12px;
    font-size: 1rem;
    font-family: 'Poppins', sans-serif;
    transition: all 0.3s ease;
  }

  .input-field:focus, .textarea-field:focus {
    border-color: #0f65d4;
    outline: none;
    box-shadow: 0 0 0 3px rgba(255,62,0,0.1);
  }

  .textarea-field {
    min-height: 120px;
    resize: vertical;
  }

  .submit-button {
    width: 100%;
    padding: 1rem;
    background: #00a2ff;
    color: white;
    border: none;
    border-radius: 12px;
    font-size: 1.1rem;
    font-weight: 600;
    letter-spacing: 0.5px;
    cursor: pointer;
    transition: all 0.3s ease;
    font-family: 'Poppins', sans-serif;
  }

  .submit-button:hover {
    background: #0583ebb0;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(255,62,0,0.2);
  }

  .submit-button:disabled {
    background: #cccccc3d;
    transform: none;
    box-shadow: none;
  }

  .comments-list {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
  }

  .comment {
    background: rgba(255, 255, 255, 0);
    padding: 1.5rem;
    border-radius: 16px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.06);
    transition: transform 0.3s ease;
  }

  .comment:hover {
    transform: translateY(-3px);
  }

  .comment-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
  }

  .user-info {
    display: flex;
    align-items: center;
    gap: 1rem;
  }

  .user-avatar {
    width: 40px;
    height: 40px;
    background: #00b7ff;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
  }

  .user-name {
    color: #333;
    font-size: 1.1rem;
    font-weight: 600;
    letter-spacing: 0.2px;
  }

  .date {
    color: #666;
    font-size: 0.9rem;
    font-weight: 400;
    letter-spacing: 0.5px;
  }

  .comment-text {
    color: #444;
    line-height: 1.7;
    font-size: 1.1rem;
    font-weight: 400;
    letter-spacing: 0.2px;
  }

  .error {
    background: #fff1f0;
    color: #ff3e00;
    padding: 1rem;
    border-radius: 12px;
    text-align: center;
    margin: 1rem 0;
  }

  @media (max-width: 768px) {
    .comments-container {
      padding: 1rem;
    }

    .title {
      font-size: 2rem;
    }

    .comment {
      padding: 1rem;
    }
  }
</style>
