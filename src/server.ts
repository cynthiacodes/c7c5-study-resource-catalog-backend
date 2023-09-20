import cors from "cors";
import dotenv from "dotenv";
import express from "express";
import { Client } from "pg";
import { getEnvVarOrFail } from "./support/envVarUtils";
import { setupDBClientConfig } from "./support/setupDBClientConfig";
import { Opinion, OpinionWithComment, Resource, Study } from "./Interfaces";
import morgan from "morgan";

dotenv.config(); //Read .env file lines as though they were env vars.

const dbClientConfig = setupDBClientConfig();
const client = new Client(dbClientConfig);

//Configure express routes
const app = express();

app.use(morgan("combined"));
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
        const response = await client.query(
            "SELECT * FROM RESOURCES ORDER BY resource_id DESC;"
        );
        res.status(200).json(response.rows);
    } catch (error) {
        console.error(error);
        res.status(500).send("An error occurred. Check server logs.");
    }
});
app.get<{ id: string }>("/resources/:id", async (req, res) => {
    try {
        const id = req.params.id;
        const query = "SELECT * FROM RESOURCES WHERE resource_id = $1";
        const values = [id];
        const response = await client.query(query, values);
        res.status(200).json(response.rows);
    } catch (error) {
        console.error(error);
        res.status(500).send("An error occurred. Check server logs.");
    }
});

app.post<{}, {}, Resource>("/resources", async (req, res) => {
    try {
        const {
            resource_name,
            author_name,
            url,
            description,
            tags,
            content_type,
            recommended_stage,
            user_id,
            creator_opinion,
            creator_reason,
        } = req.body;
        const query =
            "INSERT INTO RESOURCES (resource_name,author_name,url,description,tags,content_type,recommended_stage,user_id,creator_opinion,creator_reason) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) RETURNING *";
        const values = [
            resource_name,
            author_name,
            url,
            description,
            tags,
            content_type,
            recommended_stage,
            user_id,
            creator_opinion,
            creator_reason,
        ];
        const newResource = await client.query(query, values);
        res.status(201).json(newResource.rows[0]);
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

app.get("/opinions", async (_req, res) => {
    try {
        const response = await client.query("SELECT * FROM OPINIONS");
        res.status(200).json(response.rows);
    } catch (error) {
        console.error(error);
        res.status(500).send("An error occurred. Check server logs.");
    }
});

app.get<{ resourceId: string }>(
    "/opinions/likes/:resourceId",
    async (req, res) => {
        try {
            const resourceId = req.params.resourceId;
            const query =
                "SELECT COUNT(*) FROM OPINIONS WHERE resource_id = $1 AND is_like = true";
            const values = [resourceId];
            const response = await client.query(query, values);
            res.status(200).json(response.rows);
        } catch (error) {
            console.error(error);
            res.status(500).send("An error occurred. Check server logs.");
        }
    }
);

app.get<{ resourceId: string }>(
    "/opinions/dislikes/:resourceId",
    async (req, res) => {
        try {
            const resourceId = req.params.resourceId;
            const query =
                "SELECT COUNT(*) FROM OPINIONS WHERE resource_id = $1 AND is_dislike = true";
            const values = [resourceId];
            const response = await client.query(query, values);
            res.status(200).json(response.rows);
        } catch (error) {
            console.error(error);
            res.status(500).send("An error occurred. Check server logs.");
        }
    }
);

app.post<{}, {}, OpinionWithComment>("/opinions", async (req, res) => {
    try {
        const { user_id, resource_id, comment } = req.body;
        const insertQuery =
            "INSERT INTO OPINIONS(user_id, resource_id, comment) VALUES ($1, $2, $3) RETURNING * ";
        const values = [user_id, resource_id, comment];
        const response = await client.query(insertQuery, values);

        res.status(201).json(response.rows);
    } catch (error) {
        console.error(error);
        res.status(500).send("An error occurred. Check server logs.");
    }
});

app.put<{}, {}, Opinion>("/opinions/like", async (req, res) => {
    try {
        const { user_id, resource_id } = req.body;
        const updateQuery =
            "UPDATE OPINIONS SET is_dislike = CASE WHEN is_dislike THEN false ELSE is_dislike END, is_like = NOT is_like WHERE user_id = $1 AND resource_id = $2 RETURNING * ";
        const values = [user_id, resource_id];
        const response = await client.query(updateQuery, values);
        res.status(201).json(response.rows);
    } catch (error) {
        console.error(error);
        res.status(500).send("An error occurred. Check server logs.");
    }
});

app.put<{}, {}, Opinion>("/opinions/dislike", async (req, res) => {
    try {
        const { user_id, resource_id } = req.body;
        const updateQuery =
            "UPDATE OPINIONS SET is_like = CASE WHEN is_like THEN false ELSE is_like END, is_dislike = NOT is_dislike WHERE user_id = $1 AND resource_id = $2 RETURNING * ";
        const values = [user_id, resource_id];
        const response = await client.query(updateQuery, values);
        res.status(201).json(response.rows);
    } catch (error) {
        console.error(error);
        res.status(500).send("An error occurred. Check server logs.");
    }
});
app.get<{ id: string }>("/to-study/:id", async (req, res) => {
    try {
        const id = req.params.id;
        const query = "SELECT * FROM TO_STUDY WHERE user_id = $1";
        const values = [id];
        const response = await client.query(query, values);
        res.status(200).json(response.rows);
    } catch (error) {
        console.error(error);
        res.status(500).send("An error occurred. Check server logs.");
    }
});
app.post<{}, {}, Study>("/to-study", async (req, res) => {
    try {
        const { user_id, resource_id } = req.body;
        const query =
            "INSERT INTO TO_STUDY (user_id, resource_id) VALUES($1, $2)RETURNING *";
        const values = [user_id, resource_id];
        const newResource = await client.query(query, values);
        res.status(201).json(newResource.rows[0]);
    } catch (error) {
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
