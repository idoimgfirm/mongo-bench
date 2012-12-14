for (var i = 0; i < 1e6; i++) {
    var t = {
        /*date: new Date(),
        str: "hi",
        num: 3,
        float: 3.1415,
        regex: /hi/,
        array: [
            1, 2, 3,
            {
                object: [{num: 1}]
            }
        ]*/
    };
    db.tests.save(t);
}
