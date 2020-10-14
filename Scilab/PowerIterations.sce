function  mayorAbsVal= mayorAbsValue(vector)
    mayorAbs = abs(vector(1))
    mayor_en_Valor_abs = vector(1)
    [size_F, size_C] = size(vector)
    for i = 1:size_F
        if mayorAbs  < abs(vector(i))then
            mayor_en_Valor_abs  = vector(i)
        end
    end
    mayorAbsVal = mayor_en_Valor_abs
endfunction

function [vecotrpropio, eigenvalue, array]= iterative_function(iteraciones, vectorSemilla,matriz)
    cx = matriz*vectorSemilla
    mayor_en_Valor_abs = mayorAbsValue(cx)
    xi = cx/mayor_en_Valor_abs
    for i = 1:iteraciones
        cx = matriz*vectorSemilla
        mayor_en_Valor_abs = mayorAbsValue(cx) 
        array(i) = mayor_en_Valor_abs
        xi = cx/mayor_en_Valor_abs
        vectorSemilla = xi
    end
    vecotrpropio = vectorSemilla
    eigenvalue = mayor_en_Valor_abs
endfunction

function [vecPropio, valPropio] = power_iteration(M)
    e = 10^-9
    n = size(M)(1)
    V = ones(n,1)
    
    first=M*V
    approxEigenValue = mayorAbsValue(first)
    newVector = first/approxEigenValue 
    prevApprox = approxEigenValue + 1
    
    while (abs(approxEigenValue - prevApprox) >= e)
        newVector = M*newVector
        prevApprox = approxEigenValue
        approxEigenValue = mayorAbsValue(newVector)
        newVector = newVector/approxEigenValue
    end
    vecPropio = newVector
    valPropio = approxEigenValue
    
endfunction

//test = [0 1 0 1 0; 1 0 1 1 1; 0 0 0 0 1; 1 0 1 0 1; 0 1 1 0 0]
test = [0 1 1 1 1 1 1  ; 1 0 0 1 1 1 1 ; 0 0 0 0 1 1 0 ; 0 1 1 0 0 0 0 ; 1 1 0 1 0 1 1; 0 1 1 0 1 0 1; 1 1 1 0 1 1 0]
[eigenVec, eigenVal] = power_iteration(test)

disp("Utilizando epsilon minimo (e=10^-9)")
disp(eigenVec)
disp(eigenVal)

n1 = size(test)(1)
V1 = ones(n1,1)

[eigenVec1, eigenVal1,array] = iterative_function(20,V1,test)
disp("20 iteraciones")
disp(eigenVec1)
disp(eigenVal1)

s = sum(eigenVec)
for i = 1:n1
    eigenVec(i) = eigenVec(i)/s
end

disp("Despues de normalizar",eigenVec)
