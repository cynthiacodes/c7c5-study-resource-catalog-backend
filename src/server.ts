import cors from "cors";
import dotenv from "dotenv";
import express from "express";
import { Client } from "pg";
import { getEnvVarOrFail } from "./support/envVarUtils";
import { setupDBClientConfig } from "./support/setupDBClientConfig";

dotenv.config(); //Read .env file lines as though they were env vars.

const dbClientConfig = setupDBClientConfig();
const client = new Client(dbClientConfig);

//Configure express routes
const app = express();

app.use(express.json()); //add JSON body parser to each following route handler
app.use(cors()); //add CORS support to each following route handler

app.get("/", async (_req, res) => {
    res.json({ msg: "Hello! There's nothing interesting for GET /" });
});

app.get("/users", async (_req, res) => {
    try {
        const response = await client.query("SELECT * FROM USERS");
        res.status(200).json(response.rows);
    } catch (error) {
        console.error(error);
        res.status(500).send("An error occurred. Check server logs.");
    }
});

app.get("/resources", async (_req, res) => {
    try {
        const response = await client.query("SELECT * FROM RESOURCES");
        res.status(200).json(response.rows);
    } catch (error) {
        console.error(error);
        res.status(500).send("An error occurred. Check server logs.");
    }
});

app.get("/opinions", async (_req, res) => {
    try {
        const response = await client.query("SELECT * FROM OPINIONS");
        res.status(200).json(response.rows);
    } catch (error) {
        console.error(error);
        res.status(500).send("An error occurred. Check server logs.");
    }
});

app.post("/add-opinion", async (req, res) => {
    try {
        const { user_id, resource_id, comment, likes, dislikes } = req.body;
        const insertQuery =
            "INSERT INTO OPINIONS(user_id, resource_id, comment, likes, dislikes) VALUES ($1, $2, $3, $4, $5) RETURNING * ";
        const values = [user_id, resource_id, comment, likes, dislikes];
        const response = await client.query(insertQuery, values);

        res.status(201).json(response.rows);
    } catch (error) {
        console.error(error);
        res.status(500).send("An error occurred. Check server logs.");
    }
});

app.get("/health-check", async (_req, res) => {
    try {
        //For this to be successful, must connect to db
        await client.query("select now()");
        res.status(200).send("system ok");
    } catch (error) {
        //Recover from error rather than letting system halt
        console.error(error);
        res.status(500).send("An error occurred. Check server logs.");
    }
});

app.delete<{ id: string }>("/to-study/:id", async (req, res) => {
    try {
        const id = req.params.id;
        const deleteQuery = "DELETE FROM TO_STUDY WHERE study_item_id = $1";
        const values = [id];
        await client.query(deleteQuery, values);
        res.status(201).json(`study item ${id} has been deleted`);
    } catch (error) {
        console.error(error);
        res.status(500).send("An error occurred. Check server logs.");
    }
});

app.delete<{ id: string }>("/resources/:id", async (req, res) => {
    try {
        const id = req.params.id;
        const deleteQuery = "DELETE FROM RESOURCES WHERE resource_id = $1";
        const values = [id];
        await client.query(deleteQuery, values);
        res.status(201).json(`resource ${id} has been deleted`);
    } catch (error) {
        console.error(error);
        res.status(500).send("An error occurred. Check server logs.");
    }
});

connectToDBAndStartListening();

async function connectToDBAndStartListening() {
    console.log("Attempting to connect to db");
    await client.connect();
    console.log("Connected to db!");

    const port = getEnvVarOrFail("PORT");
    app.listen(port, () => {
        console.log(
            `Server started listening for HTTP requests on port ${port}.  Let's go!`
        );
    });
}
