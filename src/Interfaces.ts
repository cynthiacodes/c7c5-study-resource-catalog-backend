export interface Resource {
    resource_name: string;
    author_name: string;
    url: string;
    description: string;
    tags: string;
    content_type: string;
    recommended_stage: string;
    user_id: number;
    creator_opinion: string;
    creator_reason: string;
}

export interface Study {
    user_id: number;
    resource_id: number;
}

export interface Opinion {
    user_id: number;
    resource_id: number;
    comment: string;
}
