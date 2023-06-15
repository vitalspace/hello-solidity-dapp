<script lang="ts">
  import MestamaskIcon from "./metamaskIcon.svelte";
  export let app;
  export let message; 
</script>

<div class="my-2">
  <button
    on:click={() => app()}
    class="border-2 text-center w-full bg-[#A3A5D2] outline-none hover:bg-[#BBB4CD] transition-all py-2 flex justify-center"
  >
    {#if message}
        <p>{message}</p>
        {:else}
        <MestamaskIcon />
    {/if}

  </button>
</div>
