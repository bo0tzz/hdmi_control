<script lang="ts">
  import { Node, Group, Svelvet } from "svelvet";

  let inputs = [
    {
      name: "Chromecast",
      id: "in-1",
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
</script>

<div class="h-screen">
  <Svelvet id="matrix" fitView={true}>
    <!-- <Group
      color="teal"
      groupName="Inputs"
      position={{ x: 0, y: 0 }}
      width={220}
      height={inputs.length * 110 + 10}
    > -->
    {#each inputs as input, i}
      <Node
        label={input.name}
        id={input.id}
        position={{ x: 0, y: 10 + 110 * i }}
        inputs={0}
      />
    {/each}
    <!-- </Group> -->
    <!-- <Group
      color="orange"
      groupName="Outputs"
      position={{ x: 300, y: 0 }}
      width={220}
      height={outputs.length * 110 + 10}
    > -->
    {#each outputs as output, i}
      <Node
        label={output.name}
        id={output.id}
        position={{ x: 300, y: 10 + 110 * i }}
        outputs={0}
      />
    {/each}
    <!-- </Group> -->
  </Svelvet>
</div>
