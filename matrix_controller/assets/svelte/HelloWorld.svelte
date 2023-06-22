<script lang="ts">
  export let target;
  export let pushEvent;

  function update() {
    pushEvent("set_target", { target });
  }
</script>

<p>Hello to {target} from Svelte!</p>
<input bind:value={target} on:change={update} />
