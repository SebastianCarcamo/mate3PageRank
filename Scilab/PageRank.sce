
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

function [newM] = firstT(M)
    n = size(M)(1)
    for i = 1:n
        tot = sum(M(:,i))
        if tot ~= 0 then
            for j = 1:n
                M(j,i) = M(j,i)/tot
            end
        end
    end
    newM = M
endfunction

function [ranks] = rankVector(V)
    ranks = zeros(size(V)(1),1)
    for i = 1:size(V)(1)
        r = 1
        s = 1
        for j = 1:size(V)(1)
            if j ~= i & V(j) < V(i) then
            r = r+1
            end
            if j ~= i & V(j) == V(i) then
                s = s+1
            end
        end
        ranks(i) = r + 0.5*(s-1)
    end
endfunction

function[random] = randomNum(maxim)

    minim = 1
    random = floor(minim+(maxim)*rand())
endfunction

function[random] = randomExcepti(maxim,i)

    minim = 1
    random = randomNum(maxim)
    while random == i
        random = randomNum(maxim)
    end
endfunction

function [M] = createMatrixRandom(n)
    rand('seed',getdate('s'))
    M = zeros(n,n)
    for i = 1:n
        for j = 1:n
            if i ~= j then
                r = rand()
                if r<0.5 then
                    M(i,j) = 1
                end
            end 
        end
    end 
    
    for i = 1:n
        columna = randomExcepti(n,i)
        fila = randomExcepti(n,i)
        M(columna,i) = 1
        M(i,fila) = 1
    end
endfunction

function [vector] = normalizar(vector)
    suma = sum(vector)
    for i = 1:size(vector)(1)
        vector(i) = vector(i)/suma
    end

endfunction




//M = createMatrixRandom(12)
//M = [0 1 1 1 1 1 1  ; 1 0 0 1 1 1 1 ; 0 0 0 0 1 1 0 ; 0 1 1 0 0 0 0 ; 1 1 0 1 0 1 1; 0 1 1 0 1 0 1; 1 1 1 0 1 1 0]
//M =[2 -12  ; 1 -5 ]
M = [0 1 0 1 0; 1 0 1 1 1; 0 0 0 0 1; 1 0 1 0 1; 0 1 1 0 0]
M2 = firstT(M)

[ncol, nfil] = size(M2)

//vector semilla de ejemplo 
V = ones(nfil,1)
iteraciones = 20
[vecotrpropio, eigenvalue, array_eigenvalue]=iterative_function(iteraciones, V , M)


vecotrpropio_ = normalizar(vecotrpropio)



disp(array_eigenvalue)
//E es la conversion de R. De Vector Columna a Vector Fila
E = vecotrpropio_.'


//Se concatena M (Matriz de 1s del inicio) con el vector fila Rank (E)
Final = [M;E]

disp( Final)


//se edita el CSV

//csvWrite(Final, 'output.txt')
csvWrite(Final, 'output.csv');



