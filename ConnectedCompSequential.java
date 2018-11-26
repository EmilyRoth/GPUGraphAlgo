import java.util.Arrays;

public class ConnectedCompSequential {

	//test 1, matching cu files
	static int [] adj_lists = {1, 2, 0, 3, 0, 3, 1, 2, 5, 4, 7, 8, 6, 10, 6, 9, 10, 8, 7, 8};
	static int [] sizes = {2, 2, 2, 2, 1, 1, 2, 2, 3, 1, 2};
	static int vertices = 11;

	static boolean [] visited = {false,false,false,false,false,false,false,false,false,false,false};

	static int [] output = new int[vertices];

	public static void main (String [] args) {

		int count = 0;
		while(!checkDone()) {
			System.out.println("" + Arrays.toString(visited));

			int search = 0;
			for(int i = 0; i < visited.length; i++) {
				if(!visited[i]) {
					search = i; break;
				}
			}
			System.out.println("" + search);
			doDFS(search, search);
			count ++;
		}
		System.out.println("" + count + " " + Arrays.toString(output));
	}

	public static void doDFS(int v, int color) {
		// label v as discovered
		visited[v] = true;
		output[v] = color;
		// for all edges from v to w in G.adjacentEdges(v) do
		for (int i = 0; i < sizes[v]; i++) {
			// if vertex w is not labeled as discovered then
			if(!visited[adj_lists[getOffset(v) + i]]) {
				// recursively call DFS(G,w)
				doDFS(adj_lists[getOffset(v) + i], color);

			}
		}
	}

	public static boolean checkDone() {
		for(boolean node : visited)
			if(!node)
				return node;
		return true;
	}

	public static int getOffset(int node) {
		int offset = 0;
		for (int i = 0; i < node; i++) {
			offset += sizes[i];
		}
		return offset;
	}
}