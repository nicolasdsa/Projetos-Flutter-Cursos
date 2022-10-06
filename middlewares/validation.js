const ApiError = require("../utils/apiError");

const validationMiddleware = ({bodySchema, paramsSchema, querySchema}) => {

    return (req, res, next) => {
        
        if(bodySchema){
            const result = bodySchema.validate(req.body);
            if(result.error){
                return res.status(400).send(result);
            }
        }

        if(paramsSchema){
            const result = paramsSchema.validate(req.params);
            if(result.error){
                return res.status(400).send(result);
            }
        }

        if(querySchema){
            const result = querySchema.validate(req.query);
            if(result.error){
                return res.status(400).send(result);
            }
        }
        return next();
    }

}

module.exports = validationMiddleware;