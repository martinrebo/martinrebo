// Effective TS examples
// Preface
let v = {str: 'hell', num: 43}


//* #Item6: Use IDE TS
// The intent in the first branch of the if statement was to filter down to just the objects,
//  namely, the HTMLElements. But oddly enough, in JavaScript typeof null is "object", 
// so elOrId could still be null in that branch. 

function getElement(elOrId: string | HTMLElement | null): HTMLElement {
  if (typeof elOrId === 'object') {
    return elOrId;
    // ~~~ Type 'HTMLElement | null' is not assignable to type 'HTMLElement'
  } else if (elOrId === null) {
    return document.body;
  }
  elOrId
  // ^? (parameter) elOrId: string
  return document.getElementById(elOrId);
  // ~~~ Type 'HTMLElement | null' is not assignable to type 'HTMLElement'
}

// You can fix this by putting the null check first.
//  The second error is because document.getElementById can return null, 
// so you need to handle that case as well, perhaps by throwing an exception

function getElementFixed(elOrId: string|HTMLElement|null): HTMLElement {
  if (elOrId === null) {
    return document.body;
  } else if (typeof elOrId === 'object') {
    return elOrId;
    //     ^? (parameter) elOrId: HTMLElement
  }
  const el = document.getElementById(elOrId);
  //                                 ^? (parameter) elOrId: string
  if (!el) {
    throw new Error(`No such element ${elOrId}`);
  }
  return el;
  //     ^? const el: HTMLElement
}