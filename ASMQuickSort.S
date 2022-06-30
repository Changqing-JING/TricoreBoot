.globl asmQuickSort

//asmDivision(int list[], int left, int right)
asmDivision:
// d4 = left, d5=right
// a4 = list
    addsc.a	%a12, %a4, %d4, 2 // a12 = &list[left]
    ld.w %d13, [%a12] //base = *a12
.LOOP: //while left<right
    jge %d4, %d5, .asmDivisionEnd
.LOOP_RIGHT:  //while (left < right
    jge %d4, %d5, .LOOP_RIGHT_END
    //&& list[right] >= base
    addsc.a	%a12, %a4, %d5, 2 // a12 = &list[right]
    ld.w %d14, [%a12] //currentRight = *a12
    jlt %d14, %d13, .LOOP_RIGHT_END
    add %d5, -1 //right--
    j .LOOP_RIGHT
   
.LOOP_RIGHT_END:
     //list[left] = list[right];
    addsc.a	%a12, %a4, %d5, 2 // a12 = &list[right]
    ld.w %d14, [%a12] //currentRight = *a12
    addsc.a	%a12, %a4, %d4, 2 // a12 = &list[left]
    st.w [%a12], %d14 // *a12 = currentRight

.LOOP_LEFT: //while (left < right
    jge %d4, %d5, .LOOP_LEFT_END
    //&& list[left] <= base
    addsc.a %a12, %a4, %d4, 2 //a12 = &list[left]
    ld.w %d14, [%a12] //d14 = currentLeft = *a12
    jlt %d13, %d14, .LOOP_LEFT_END
    add %d4, 1 //left++
    j .LOOP_LEFT

.LOOP_LEFT_END:
    //list[right] = list[left];
    addsc.a	%a12, %a4, %d4, 2 // a12 = &list[left]
    ld.w %d14, [%a12] //d14 = currentLeft = *a12
    addsc.a	%a12, %a4, %d5, 2 // a12 = &list[right]
    st.w [%a12], %d14 // *a12 = currentLeft
    
    j .LOOP
.asmDivisionEnd:
    //list[left] = base;
    addsc.a	%a12, %a4, %d4, 2 // a12 = &list[left]
    st.w [%a12], %d13 // *a12 = base

    //return left
    mov %d2, %d4
    ret

asmQuickSort:
// left = d4, right = d5
// list = a4
    sub.a %sp, 8
    st.w [%sp], %d5 // *sp = right
    st.w [%sp] + 4, %d4 // *(sp+4) = left

    jge %d4, %d5, .asmQuickSortEnd // if left<right

    call asmDivision

    // d2= base = asmDivision()
    
    add %d13, %d2, 1 // d13 = base + 1
    add %d5, %d2, -1 // d5 = base - 1

    ld.w %d4, [%sp] + 4 // d4 = *(sp+4) = left

    call asmQuickSort //asmQuickSort(%a4=list, %d4=left, %d5=base-1)

    mov %d4, %d13 //d4 = base+1
    ld.w %d5, [%sp] // d4 = *sp = right
    call asmQuickSort //asmQuickSort(%a4=list, %d4=base+1, %d5=right)
    
   

.asmQuickSortEnd:
    ret
