/* 
  Computes the string hash used by the JavaScript implementation.
  
   Characters are processed from the end of the string, matching
   `charCodeAt`, and each multiplication is wrapped to a signed 32-bit value
   like `Math.imul`.
  
   function hashCode (s) => {
     let h = 0,
       i = s.length - 1;
     while (i >= 0) h = Math.imul(31, h) + s.charCodeAt(i--);
     return h > 0 ? h : Number.MAX_SAFE_INTEGER + h;
   };
*/

int hash(String s) {
  var h = 0;
  for (var i = s.length - 1; i >= 0; i--) {
    final unsigned = (31 * h + s.codeUnitAt(i)) & 0xffffffff;
    h = unsigned >= 0x80000000 ? unsigned - 0x100000000 : unsigned;
  }

  return h > 0 ? h : 9007199254740991 + h;
}
