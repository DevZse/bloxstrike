local util = {}

local function calcCorners(part)
    local size = part.Size
    local pos = part.Position
    local lookVec = part.LookVector
    local rightVec = part.RightVector
    local upVec = part.UpVector
    local corners = {}
    
    for x = -0.5, 0.5, 1 do
        for y = -0.5, 0.5, 1 do
            for z = -0.5, 0.5, 1 do
                local offsetX = x * part.Size.X
                local offsetY = y * part.Size.Y
                local offsetZ = z * part.Size.Z
                
                local worldX = pos.X + rightVec.X * offsetX + upVec.X * offsetY + lookVec.X * offsetZ
                local worldY = pos.Y + rightVec.Y * offsetX + upVec.Y * offsetY + lookVec.Y * offsetZ
                local worldZ = pos.Z + rightVec.Z * offsetX + upVec.Z * offsetY + lookVec.Z * offsetZ
                
                table.insert(corners, vector.create(worldX, worldY, worldZ))
            end
        end
    end
    
    return corners
end

function util.getBoundingBox(parts)
    local minX, minY = math.huge, math.huge
    local maxX, minY = -math.huge, -math.huge
    local visible = false
    
    for _, part in parts do
        for _, corner in calcCorners(part) do
            local screenPos, onScreen = workspace.CurrentCamera:WorldToScreenPoint(corner)
            
            if onScreen then
                visible = true
                
                minX = math.min(minX, screenPos.X)
                minY = math.min(minY, screenPos.Y)
                maxX = math.max(maxX, screenPos.X)
                maxY = math.max(maxY, screenPos.Y)
            end
        end
    end
    
    if not visible then
        return
    end
    
    return {pos = vector.create(minX, minY), size = vector.create(maxX - minX, maxY - minY)}
end
