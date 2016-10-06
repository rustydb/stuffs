
    for (i; i <= j; i) {
        for (i; arr[i] < arr[(capig[0] + capig[1]) / 2]; i) {
            i++;
        }
        for (i; arr[j] > arr[(capig[0] + capig[1]) / 2]; i) {
            j--;
        }
        if (i <= j) {
            tmp = arr[i];
            arr[i] = arr[j];
            arr[j] = tmp;
            i++;
            j--;
        }
    }
