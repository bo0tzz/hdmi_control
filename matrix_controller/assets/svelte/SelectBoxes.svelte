<script lang="ts">
  export let inputs;
  export let outputs;
  export let connections;

  $: console.log(inputs);
</script>

<h3>Current connections:</h3>
<br />
{#each connections as [from, to]}
  From {inputs[from]} to {outputs[to]}
  <br />
{/each}
<br />

<h3>Add new connection</h3>
<br />
<select name="input">
  {#each Object.entries(inputs) as [val, name]}
    <option value={val}>{name}</option>
  {/each}
</select>

to

<select name="output">
  {#each Object.entries(outputs) as [val, name]}
    <option value={val}>{name}</option>
  {/each}
</select>

<button>+</button>
