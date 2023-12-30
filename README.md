# Gas Optimization Handbook

A non-exhaustive guide on the most impactful gas optimization techniques that focuses primarily on reducing the use of the `SSTORE` and `SLOAD` opcodes.

## Motivations

Let's get the elephant out of the room first — why create another gas optimization resource when there are already [so](https://www.alchemy.com/overviews/solidity-gas-optimization) [many](https://hacken.io/discover/solidity-gas-optimization/) [articles](https://www.infuy.com/blog/7-simple-ways-to-optimize-gas-in-solidity-smart-contracts/) [out](https://betterprogramming.pub/solidity-gas-optimizations-and-tricks-2bcee0f9f1f2) [there](https://0xmacro.com/blog/solidity-gas-optimizations-cheat-sheet/)?

My main criticism of these articles lies in their inclination towards breadth rather than depth. Specifically, they fall short in adequately explaining the technical details behind the optimizations discussed. Consequently, readers often resort to memorization and pattern matching instead of learning how to discern potential optimization opportunities.

Furthermore, I hold the belief that articles may not be the optimal medium for conveying technical concepts effectively, as users often lack the ability to directly engage with the code examples. Articles also necessitate the use of extraneous words to enhance the flow, but these additions may not contribute substantial value to the user.

As such, I have created this repository which contains both in-depth explanations and accompanying code snippets. This approach enables the readers to actively experiment in order to gain a deeper understanding of how these optimizations are implemented and the rationale behind their effectiveness.

## Getting Started

To get started, review the content under the [foundational knowledge](#foundation-knowledge) section. The techniques to be covered share a common underlying idea, thus establishing a solid groundwork is essential for comprehending and appreciating these strategies.

## Foundation Knowledge

- [What are opcodes?](./src/core/opcodes/README.md)
- [What is SLOAD?](./src/core/sload/README.md)
- [What is SSTORE?](./src/core/sstore/README.md)

## Optimizations

- [Avoiding zero values](./src/optimizations/avoid-zero-value/README.md)
- [Storage packing](./src/optimizations/storage-packing/)
- [Use constants or immutables for read-only variables](./src/optimizations/constants-and-immutables/README.md)
- [Use calldata over memory for read-only arguments](./src/optimizations/calldata-vs-memory/README.md)
<!-- - Cache variables that are used multiple times
- Prefer mappings over arrays
- Consider avoiding storage all together
- Keep strings less than 32 bytes <- is this an mload saving or sload saving?
- Consider storage pointers over memory <- how does this work? test it! https://www.youtube.com/watch?v=Zi4BANKFNP8
- Use access lists -->

## Acknowledgements

- [0xKalzak's](https://twitter.com/0xKalzak) [gas optimization presentation](https://snappify.com/view/f9a681c7-834c-467e-b34d-5ad443a893f2)
- [Beskay's](https://twitter.com/beskay0x) [gas guide](https://github.com/beskay/gas-guide)

## Additional Recommended Resources

- [The RareSkills Book of Solidity Gas Optimization](https://www.rareskills.io/post/gas-optimization)
- [Hari's](https://twitter.com/_hrkrshnn) [generic writeup about common gas optimizations](https://gist.github.com/hrkrshnn/ee8fabd532058307229d65dcd5836ddc)
