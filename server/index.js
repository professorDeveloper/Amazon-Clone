
const express=require('express');
const mongoose=require("mongoose");
const adminRouter = require('./routes/admin');
const authRoter =require('./routes/auth');
const productRouter =require('./routes/product');
const userRouter = require('./routes/user');


const PORT=3000;
const app=express();
app.use(express.json());
const DB="mongodb+srv://hud:Azamov2456@cluster0.yvf8scq.mongodb.net/?retryWrites=true&w=majority";
//a
app.use(authRoter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter)
//Mongo DB connections  
mongoose.connect(DB)
.then(() =>{ 
    console.log("Connected Mongo DB");
})
.catch((e) =>{
    console.log(e);
});

//API CREATE
app.listen(PORT,"0.0.0.0",() => {
    console.log("connected at ports "+PORT+" hello Hasanxon");
});
