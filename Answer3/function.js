function getNestedValue(obj, key) {
  const keys = key.split('/');
  let currentObj = obj;

  for (const k of keys) {
    if (typeof currentObj === 'object' && currentObj !== null && k in currentObj) {
      currentObj = currentObj[k];
    } else {
      return undefined;
    }
  }

  return currentObj;
}

const object = {"x": {"y": {"z": "a"}}};
const key = "x/y/z";
const result = getNestedValue(object, key);
console.log(result);
