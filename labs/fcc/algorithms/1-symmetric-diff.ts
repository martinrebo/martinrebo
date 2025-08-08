
/* The mathematical term symmetric difference (△ or ⊕) of two sets is the set of elements 
which are in either of the two sets but not in both. For example, for sets A = {1, 2, 3}
 and B = {2, 3, 4}, A △ B = {1, 4}.

Symmetric difference is a binary operation, which means it operates on only two elements. 
So to evaluate an expression involving symmetric differences among three elements (A △ B △ C), 
you must complete one operation at a time. Thus, for sets A and B above, and C = {2, 3}, A △ B △ C = (A △ B) △ C = {1, 4} △ {2, 3} = {1, 2, 3, 4}.

Create a function that takes two or more arrays and returns an array of their symmetric difference. 
The returned array must contain only unique values (no duplicates). */



function symmetricDifference1(...arrays: number[][]): number[] {
    const allValues = new Set<number>();
    const duplicateValues = new Set<number>();

    for (const array of arrays) {
        for (const value of array) {
            if (allValues.has(value)) {
                duplicateValues.add(value);
            } else {
                allValues.add(value);
            }
        }
    }

    // Remove duplicates from allValues
    for (const value of duplicateValues) {
        allValues.delete(value);
    }

    return Array.from(allValues);
}

function symmetricDifference2(...arrays: number[][]): number[] {
    const diff = (arr1: number[], arr2: number[]): number[] => [
  ...arr1.filter(e => !arr2.includes(e)),
  ...arr2.filter(e => !arr1.includes(e))
];

const sym = (...args: number[][]): number[] => [...new Set(args.reduce(diff))];
    return sym(...arrays);
}   
