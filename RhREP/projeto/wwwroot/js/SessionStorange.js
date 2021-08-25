

/*
 faz as gravações de sessões
 */
(function () {

    storeData = (key, data) => {
        sessionStorage.setItem(key, data);
    };

    getData = (key) => {
        return sessionStorage.getItem(key);
    };

    clearData = () => {
        return sessionStorage.clear();
    };

    removeItem = (key) => {
        return sessionStorage.removeItem(key);
    };

})();
