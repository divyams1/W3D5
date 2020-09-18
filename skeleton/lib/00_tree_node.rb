class PolyTreeNode
    
    def initialize(val)
        @children = [] 
        @value = val
        @parent = nil
    end

    def parent=(node) 
        parent.children.delete(self) unless parent.nil?
        @parent = node
        unless node.nil?
            node.children << self unless node.children.include?(self)
        end 
        return self
    end

    def add_child(node)
      self.children << node
      node.parent = self
    end

    def remove_child(node)
      raise if !self.children.include?(node)
      self.children.delete(node)
      node.parent = nil
    end

    def dfs(target)
      return self if self.value == target
      self.children.each do |child|
        search = child.dfs(target)
        return search unless search.nil?
      end
      nil
    end

    def bfs(target)
      line = [self]
      until line.empty?
        ele = line.shift
        return ele if ele.value == target
        ele.children.each do |child|
          line << child
        end
      end
      nil
    end

     
    attr_reader :children, :value, :parent 
end

 