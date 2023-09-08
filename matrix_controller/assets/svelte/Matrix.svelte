<script lang="ts">
  import { Node, Group, Svelvet, Edge } from "svelvet";

  let selectedInput;
  let selectedOutput;

  let inputs = [
    {
      name: "Chromecast",
      id: "in-1",
      connections: ["out-2"],
    },
    {
      name: "PC",
      id: "in-2",
    },
  ];

  let outputs = [
    {
      name: "TV",
      id: "out-1",
    },
    {
      name: "Monitor",
      id: "out-2",
    },
    {
      name: "Projector",
      id: "out-3",
    },
    {
      name: "Speakers",
      id: "out-8",
    },
  ];

  let outputConnected = (e: CustomEvent) => console.log(e.detail);

  let inputClicked = (e: CustomEvent) => {
    selectedInput = e.detail.node.id;
    if (selectedOutput) {
    }
    console.log(e.detail.node.anchors);
  };

  let outputClicked = (e: CustomEvent) => {
    console.log(e.detail.node.id);
  };
</script>

<div class="h-screen">
  <Svelvet fitView={true}>
    {#each inputs as input, i}
      <Node
        label={input.name}
        id={input.id}
        position={{ x: 0, y: 10 + 110 * i }}
        inputs={0}
        on:nodeClicked={inputClicked}
      />
    {/each}
    {#each outputs as output, i}
      <Node
        label={output.name}
        id={output.id}
        position={{ x: 300, y: 10 + 110 * i }}
        outputs={0}
        on:connection={outputConnected}
        on:nodeClicked={outputClicked}
      />
    {/each}
  </Svelvet>
</div>
